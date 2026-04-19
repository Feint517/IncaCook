import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.showSeeAll = false,
    this.onSeeAllTap,
  });

  final String title;
  final bool showSeeAll;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (showSeeAll)
          GestureDetector(
            onTap: onSeeAllTap,
            child: Row(
              children: [
                Text(
                  AppTexts.homeSeeAll,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
                const Gap(2),
                const Icon(
                  Iconsax.arrow_right_3,
                  size: 14,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
