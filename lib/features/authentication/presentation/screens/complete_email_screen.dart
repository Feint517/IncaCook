import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:incacook/core/common/styles/loaders.dart';
import 'package:incacook/core/config/supabase_config.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/features/authentication/data/repositories/auth_repository.dart';
import 'package:incacook/core/utils/log.dart';

/// Shown after a social login whose provider returned no email (Facebook).
/// The user adds an email and verifies it via a Supabase **magic link**:
///
///   1. backend attaches the (unconfirmed) email to the auth user (admin);
///   2. the CLIENT sends the magic link (`signInWithOtp` with
///      `emailRedirectTo`), so the PKCE verifier lives in the app and the
///      `incacook://auth/callback?flow=complete_email` redirect completes
///      in-app;
///   3. on the callback (or the manual "J'ai vérifié" re-check) the session is
///      confirmed, persisted, synced, and the screen pops `true` so signup
///      continues to phone verification.
///
/// If the Supabase template uses `{{ .Token }}` (a 6-digit code) instead of a
/// link, the user can fall back to entering the code. Never logs tokens, codes,
/// or the full email.
class CompleteEmailScreen extends StatefulWidget {
  const CompleteEmailScreen({super.key});

  @override
  State<CompleteEmailScreen> createState() => _CompleteEmailScreenState();
}

class _CompleteEmailScreenState extends State<CompleteEmailScreen>
    with WidgetsBindingObserver {
  final AuthRepository _auth = AuthRepository.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _linkSent = false;
  bool _busy = false;
  bool _verified = false; // guard against double-completion (after Continuer)
  bool _verifiedDetected = false; // email confirmed → "Continuer" enabled
  bool _showOtp = false; // OTP fallback (when the template sends a code)
  String _email = '';

  StreamSubscription<AuthState>? _authSub;
  StreamSubscription<Uri>? _linkSub;

  static final RegExp _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    // Re-check on app resume: the surest signal that the user clicked the
    // link is them coming BACK to the app. We then ask the server whether the
    // email is confirmed — independent of whether the deep link auto-routed.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _linkSent && !_verified) {
      _recheck(announce: false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSub?.cancel();
    _linkSub?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Send the magic link
  // --------------------------------------------------------------------------
  Future<void> _sendLink() async {
    if (_busy) return;
    final email = _emailController.text.trim();
    if (!_emailRe.hasMatch(email)) {
      CustomLoaders.warningSnackBar(
        title: AppTexts.completeEmailTitle,
        message: AppTexts.completeEmailInvalid,
      );
      return;
    }
    setState(() => _busy = true);
    try {
      // 1) Attach the email to this auth user (backend admin) so the magic
      //    link binds to THIS account, then 2) send the link from the client
      //    so the PKCE verifier is stored here and the callback completes
      //    in-app.
      await _auth.attachEmail(email);
      await Supabase.instance.client.auth.signInWithOtp(
        email: email,
        emailRedirectTo: SupabaseConfig.completeEmailRedirectUrl,
        shouldCreateUser: false,
      );
      logInfo('[EmailVerify] magic link sent');
      setState(() {
        _email = email;
        _linkSent = true;
        _showOtp = false;
        _otpController.clear();
      });
      _listenForCallback();
    } on ApiFailure catch (e) {
      CustomLoaders.errorSnackBar(title: AppTexts.completeEmailTitle, message: e.message);
    } catch (_) {
      CustomLoaders.errorSnackBar(
        title: AppTexts.completeEmailTitle,
        message: AppTexts.completeEmailError,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // --------------------------------------------------------------------------
  // Auto-completion via the deep-link callback
  // --------------------------------------------------------------------------
  void _listenForCallback() {
    _authSub ??= Supabase.instance.client.auth.onAuthStateChange.listen((state) {
      // The new (email-confirmed) session arrives via supabase_flutter's
      // deep-link observer. Only a session whose email is confirmed completes;
      // the pre-link Facebook session (no email) is naturally ignored.
      switch (state.event) {
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.userUpdated:
        case AuthChangeEvent.tokenRefreshed:
          _maybeComplete(state.session);
        default:
          break;
      }
    });
    _linkSub ??= AppLinks().uriLinkStream.listen((uri) {
      if (uri.queryParameters['flow'] == 'complete_email') {
        logInfo('[EmailVerify] callback received flow=complete_email');
        // Best-effort: supabase_flutter processes the session async; the
        // onAuthStateChange listener above is the reliable completion path.
        _maybeComplete(Supabase.instance.client.auth.currentSession);
      }
    });
  }

  void _maybeComplete(Session? session) {
    if (_verified || _verifiedDetected || session == null) return;
    final user = session.user;
    if (user.emailConfirmedAt != null && (user.email?.isNotEmpty ?? false)) {
      _onDetected();
    }
  }

  /// Email confirmed → ENABLE the "Continuer" button (don't auto-navigate; the
  /// user taps it to finalise).
  void _onDetected() {
    if (_verified || _verifiedDetected) return;
    if (mounted) setState(() => _verifiedDetected = true);
  }

  /// Asks the server whether the magic link confirmed the email. Runs silently
  /// on app resume ("when you come back"), and loudly via "Vérifier
  /// maintenant". On success it enables "Continuer".
  Future<void> _recheck({required bool announce}) async {
    if (_verified || _verifiedDetected) return;
    if (announce) {
      if (_busy) return;
      setState(() => _busy = true);
    }
    try {
      final res = await Supabase.instance.client.auth.getUser();
      final user = res.user;
      if (user?.emailConfirmedAt != null && (user?.email?.isNotEmpty ?? false)) {
        _onDetected();
      } else if (announce) {
        CustomLoaders.warningSnackBar(
          title: AppTexts.completeEmailTitle,
          message: AppTexts.completeEmailNotVerifiedYet,
        );
      }
    } catch (_) {
      if (announce) {
        CustomLoaders.warningSnackBar(
          title: AppTexts.completeEmailTitle,
          message: AppTexts.completeEmailNotVerifiedYet,
        );
      }
    } finally {
      if (announce && mounted) setState(() => _busy = false);
    }
  }

  /// The enabled "Continuer" button. Uses the current session (email-confirmed
  /// after the magic link; even a stale Facebook session works since the
  /// backend resolves the now-confirmed email server-side).
  Future<void> _proceed() async {
    if (_busy || _verified) return;
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      CustomLoaders.warningSnackBar(
        title: AppTexts.completeEmailTitle,
        message: AppTexts.completeEmailNotVerifiedYet,
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await _completeMagicLink(session);
    } finally {
      if (mounted && !_verified) setState(() => _busy = false);
    }
  }

  Future<void> _completeMagicLink(Session session) async {
    if (_verified) return;
    // Persist the new (email-bearing) session so the bearer carries the email;
    // sync is best-effort (the email is already confirmed on Supabase).
    await _auth.persistOAuthSession(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      expiresAt: session.expiresAt ?? 0,
    );
    try {
      await _auth.syncOAuthUser();
    } on ApiFailure {
      // ignore — email is confirmed on Supabase; onboarding resolves it.
    }
    _finish();
  }

  // --------------------------------------------------------------------------
  // OTP fallback ({{ .Token }} templates)
  // --------------------------------------------------------------------------
  Future<void> _verifyCode() async {
    if (_busy || _verified) return;
    final code = _otpController.text.trim();
    if (code.length < 6) return;
    setState(() => _busy = true);
    try {
      // Backend verifies + confirms the email + returns/persists a fresh
      // session (with the email).
      await _auth.verifyEmailOtp(code: code, email: _email);
      _finish();
    } on ApiFailure catch (e) {
      CustomLoaders.errorSnackBar(
        title: AppTexts.completeEmailOtpTitle,
        message: e.message.isNotEmpty ? e.message : AppTexts.completeEmailInvalidCode,
      );
    } catch (_) {
      CustomLoaders.errorSnackBar(
        title: AppTexts.completeEmailOtpTitle,
        message: AppTexts.completeEmailError,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Shared success path: snackbar + pop(true). The caller (WelcomeController)
  /// then routes onward (signup continues to phone verification).
  void _finish() {
    if (_verified) return;
    _verified = true;
    _authSub?.cancel();
    _linkSub?.cancel();
    logSuccess('[EmailVerify] email verified=true');
    CustomLoaders.successSnackBar(
      title: AppTexts.completeEmailTitle,
      message: AppTexts.completeEmailVerifiedSuccess,
    );
    logInfo('[EmailVerify] advancing to phoneVerification');
    if (mounted) Get.back<bool>(result: true);
  }

  // --------------------------------------------------------------------------
  // UI
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.completeEmailTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.md,
          ),
          child: _linkSent ? _buildSentStep(context) : _buildEmailStep(context),
        ),
      ),
    );
  }

  Widget _buildEmailStep(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppTexts.completeEmailSubtitle, style: textTheme.bodyMedium),
        const Gap(AppSizes.lg),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enabled: !_busy,
          decoration: const InputDecoration(labelText: AppTexts.completeEmailLabel),
          onSubmitted: (_) => _sendLink(),
        ),
        const Gap(AppSizes.lg),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _busy ? null : _sendLink,
            child: _busy
                ? const _ButtonSpinner()
                : const Text(AppTexts.completeEmailSendLinkCta),
          ),
        ),
      ],
    );
  }

  Widget _buildSentStep(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _verifiedDetected
              ? AppTexts.completeEmailDetected
              : AppTexts.completeEmailLinkSent,
          style: textTheme.bodyMedium,
        ),
        const Gap(AppSizes.lg),
        // Disabled ("En attente de vérification…") until the app detects the
        // email is confirmed — on the deep-link callback OR when you come back
        // to the app — then enabled ("Continuer") for you to tap.
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: (_busy || !_verifiedDetected) ? null : _proceed,
            child: _busy
                ? const _ButtonSpinner()
                : Text(
                    _verifiedDetected
                        ? AppTexts.completeEmailContinueCta
                        : AppTexts.completeEmailWaiting,
                  ),
          ),
        ),
        // Manual re-check while still waiting (in case the resume check missed).
        if (!_verifiedDetected) ...[
          const Gap(AppSizes.xs),
          Center(
            child: TextButton(
              onPressed: _busy ? null : () => _recheck(announce: true),
              child: const Text(AppTexts.completeEmailCheckNow),
            ),
          ),
        ],
        const Gap(AppSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _busy ? null : () => setState(() => _linkSent = false),
              child: const Text(AppTexts.completeEmailChangeCta),
            ),
            TextButton(
              onPressed: _busy ? null : _sendLink,
              child: const Text(AppTexts.completeEmailResendCta),
            ),
          ],
        ),
        const Divider(height: AppSizes.lg),
        // OTP fallback: only needed if the Supabase template sends a 6-digit
        // code ({{ .Token }}) instead of a magic link.
        if (!_showOtp)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: _busy ? null : () => setState(() => _showOtp = true),
              child: const Text(AppTexts.completeEmailHaveCode),
            ),
          )
        else ...[
          Text(
            AppTexts.completeEmailOtpSubtitle(_email),
            style: textTheme.bodySmall,
          ),
          const Gap(AppSizes.md),
          Pinput(
            length: 6,
            controller: _otpController,
            enabled: !_busy,
            onCompleted: (_) => _verifyCode(),
          ),
          const Gap(AppSizes.md),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: _busy ? null : _verifyCode,
              child: const Text(AppTexts.completeEmailVerifyCta),
            ),
          ),
        ],
      ],
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
    );
  }
}
