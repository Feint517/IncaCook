import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:homemade/core/constants/sizes.dart';
import 'package:homemade/core/utils/theme/theme_extensions.dart';

class UserTypeCard extends StatelessWidget {
  const UserTypeCard({
    super.key,
    required this.animation,
    required this.title,
    // required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String animation;
  final String title;
  // final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.appColors;
    final fg = selected ? colors.selectedOnSurface : scheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: selected
              ? colors.selectedSurface
              : scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Lottie.asset(animation, fit: BoxFit.contain)),
            const Gap(AppSizes.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: fg,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(AppSizes.xs),
            // Text(
            //   subtitle,
            //   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: fg),
            //   textAlign: TextAlign.center,
            //   maxLines: 3,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}
