import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:incacook/core/common/styles/loaders.dart';
import 'package:incacook/core/constants/animations.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/core/utils/helpers/network_manager.dart';
import 'package:incacook/core/utils/popups/fullscreen_loader.dart';
import 'package:incacook/features/authentication/data/models/requests/signin_request.dart';
import 'package:incacook/features/authentication/data/repositories/auth_repository.dart';
import 'package:incacook/features/authentication/services/post_auth_router.dart';

class LoginController extends GetxController {
  LoginController({
    AuthRepository? authRepository,
    PostAuthRouter? router,
  })  : _authRepository = authRepository ?? Get.find<AuthRepository>(),
        _router = router ?? Get.find<PostAuthRouter>();

  final AuthRepository _authRepository;
  final PostAuthRouter _router;

  // Form state.
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Network state.
  final isLoading = false.obs;
  final submitError = ''.obs;

  static const _kRememberEmail = 'incacook.remember_me_email';

  @override
  void onInit() {
    super.onInit();
    // Restore the last-used email if the user previously checked
    // "remember me". Password is intentionally NOT cached — that's what
    // refresh tokens (`flutter_secure_storage`) are for.
    final saved = localStorage.read<String>(_kRememberEmail);
    if (saved != null && saved.isNotEmpty) {
      email.text = saved;
      rememberMe.value = true;
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  /// Email + password sign-in.
  ///
  /// On success, persists tokens (via [AuthRepository.signin]'s side
  /// effect) and hands off to [PostAuthRouter] for routing — same rules
  /// as cold-start bootstrap, so a half-completed wizard is resumed
  /// in-place instead of restarted from page 0.
  Future<void> emailAndPasswordSignIn() async {
    submitError.value = '';
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    if (isLoading.value) return;
    isLoading.value = true;

    var loaderShown = false;
    try {
      CustomFullscreenLoader.openLoadingDialog(
        'Logging in...',
        AppAnimations.loading,
      );
      loaderShown = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // NetworkManager itself toasts; just bail before hitting the wire.
        return;
      }

      await _authRepository.signin(
        SigninRequest(
          email: email.text.trim(),
          password: password.text,
        ),
      );

      if (rememberMe.value) {
        await localStorage.write(_kRememberEmail, email.text.trim());
      } else {
        await localStorage.remove(_kRememberEmail);
      }

      final decision = await _router.decide();
      // Stop the loader before navigating so it doesn't outlive the route.
      CustomFullscreenLoader.stopLoading();
      loaderShown = false;
      _router.navigateTo(decision);
    } on ApiFailure catch (e) {
      // §3.2: 401 → wrong credentials. Anything else → surface the
      // backend message verbatim. We do NOT navigate on error — the
      // user stays on the login screen and can retry.
      submitError.value = e.message;
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.message);
    } catch (e) {
      submitError.value = e.toString();
      CustomLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      if (loaderShown) CustomFullscreenLoader.stopLoading();
      isLoading.value = false;
    }
  }
}
