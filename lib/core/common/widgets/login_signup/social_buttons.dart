import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:incacook/core/constants/image_strings.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/widgets/effects/frosted_surface.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, this.onGoogle, this.onFacebook});

  /// Tap handlers for the provider buttons. Optional so existing callers
  /// that only want the decorative row keep working; the login screen
  /// passes the [WelcomeController] flows.
  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(logo: AppImages.googleLogo, onTap: onGoogle),
        const Gap(AppSizes.spaceBtwItems),
        _SocialButton(logo: AppImages.facebookLogo, onTap: onFacebook),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.logo, required this.onTap});

  final String logo;
  // Nullable: a null `onTap` disables (and dims) the button — used while a
  // social login is already running to block double / simultaneous launches.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1.0,
      child: FrostedSurface(
        shape: BoxShape.circle,
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.sm + 4),
              child: Image(
                image: AssetImage(logo),
                height: AppSizes.iconMd,
                width: AppSizes.iconMd,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
