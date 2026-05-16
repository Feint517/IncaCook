import 'package:get/get.dart';

import 'package:incacook/core/common/styles/loaders.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/core/services/google_auth_service.dart';
import 'package:incacook/features/authentication/data/repositories/auth_repository.dart';
import 'package:incacook/features/authentication/services/post_auth_router.dart';

/// Drives the welcome screen's third-party sign-in actions.
///
/// Today: Google. The flow mirrors [LoginController]:
///   1. Get an ID token from [GoogleAuthService] (native picker).
///   2. Exchange it for a Supabase session via
///      [AuthRepository.signInWithGoogle].
///   3. Hand off to [PostAuthRouter] — same routing rules as email
///      signin and cold-start (`role home` / `resume signup` /
///      `no profile yet`), so a first-time Google user lands at the
///      role-selection step and a returning user lands at their home.
///
/// Cancellation is silent (no toast). Real failures surface via the
/// existing error snackbar pattern.
class WelcomeController extends GetxController {
  WelcomeController({
    GoogleAuthService? googleAuth,
    AuthRepository? authRepository,
    PostAuthRouter? router,
  })  : _googleAuth = googleAuth ?? Get.find<GoogleAuthService>(),
        _authRepository = authRepository ?? Get.find<AuthRepository>(),
        _router = router ?? Get.find<PostAuthRouter>();

  final GoogleAuthService _googleAuth;
  final AuthRepository _authRepository;
  final PostAuthRouter _router;

  /// True while the Google flow is in flight (plugin → backend →
  /// router). The button binds to this for spinner + disabled state.
  final isGoogleLoading = false.obs;

  Future<void> signInWithGoogle() async {
    if (isGoogleLoading.value) return;
    isGoogleLoading.value = true;
    try {
      final idToken = await _googleAuth.signIn();
      await _authRepository.signInWithGoogle(idToken: idToken);
      final decision = await _router.decide();
      _router.navigateTo(decision);
    } on GoogleSignInCancelled {
      // User dismissed the OS picker — no error, no toast.
    } on GoogleSignInException catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Connexion Google',
        message: e.message,
      );
    } on ApiFailure catch (e) {
      // §3.1a — 400 "Bad ID token" usually means a serverClientId /
      // Supabase project mismatch. Surface the backend message verbatim.
      CustomLoaders.errorSnackBar(
        title: 'Connexion Google',
        message: e.message,
      );
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: 'Connexion Google',
        message: e.toString(),
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }
}
