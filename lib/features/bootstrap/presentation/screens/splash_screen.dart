import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:incacook/core/constants/image_strings.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/features/bootstrap/controllers/bootstrap_controller.dart';

/// Held briefly on cold start while [BootstrapController] decides where
/// to route the user (onboarding / welcome / resumed signup / role home).
///
/// The decision happens in the controller's `onReady` so this widget can
/// stay dumb — it just shows the logo + a spinner. Most cold starts spend
/// <500ms here.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BootstrapController());
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.appLogo, height: 96),
            const Gap(AppSizes.lg),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
