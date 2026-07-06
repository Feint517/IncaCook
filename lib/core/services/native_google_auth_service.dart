import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:incacook/core/config/google_auth_config.dart';
import 'package:incacook/core/config/supabase_config.dart';
import 'package:incacook/core/services/supabase_oauth_service.dart';
import 'package:incacook/core/utils/log.dart';

/// Native Google Sign-In followed by Supabase ID-token session exchange.
///
/// This avoids the hosted Supabase browser redirect for Google while still
/// ending with the same Supabase [Session] the rest of the app already knows
/// how to persist and sync with the backend.
class NativeGoogleAuthService extends GetxService {
  static const List<String> _scopes = <String>[
    'email',
    'profile',
  ];

  Future<void>? _initializing;

  Future<Session?> signIn() async {
    await _ensureInitialized();

    final GoogleSignInAccount account;
    try {
      account = await GoogleSignIn.instance.authenticate(scopeHint: _scopes);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        logInfo('[Auth][Google] native sign-in cancelled');
        return null;
      }
      logError('[Auth][Google] native sign-in failed: ${e.code}');
      throw OAuthSignInException(
          e.description ?? 'Connexion Google impossible.');
    }

    final idToken = account.authentication.idToken;
    final authorization =
        await account.authorizationClient.authorizationForScopes(_scopes) ??
            await account.authorizationClient.authorizeScopes(_scopes);
    final accessToken = authorization.accessToken;

    if (idToken == null || idToken.isEmpty) {
      throw const OAuthSignInException('Jeton Google manquant.');
    }
    if (accessToken.isEmpty) {
      throw const OAuthSignInException('Accès Google manquant.');
    }

    final response = await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    final session = response.session;
    if (session == null) {
      throw const OAuthSignInException('Session Google introuvable.');
    }
    return session;
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {
      // Best-effort local cleanup; backend/Supabase sign-out owns the session.
    }
  }

  Future<void> _ensureInitialized() {
    final initializing = _initializing;
    if (initializing != null) return initializing;

    if (!SupabaseConfig.isConfigured || !GoogleAuthConfig.isConfigured) {
      throw const OAuthSignInException('Google Sign-In non configuré.');
    }

    final future = GoogleSignIn.instance.initialize(
      clientId: _nativeClientId,
      serverClientId: GoogleAuthConfig.webClientId,
    );
    _initializing = future;
    return future;
  }

  String? get _nativeClientId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return GoogleAuthConfig.iosClientId.isEmpty
            ? null
            : GoogleAuthConfig.iosClientId;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return null;
    }
  }
}
