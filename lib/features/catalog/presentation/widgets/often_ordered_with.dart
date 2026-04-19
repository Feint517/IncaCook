import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/image_strings.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/features/home/presentation/widget/section_header.dart';

class OftenOrderedWith extends StatelessWidget {
  const OftenOrderedWith({super.key, this.onSeeAllTap});

  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: AppTexts.productOftenOrderedWith,
          showSeeAll: true,
          onSeeAllTap: onSeeAllTap,
        ),
        const Gap(AppSizes.md),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, _) => const Gap(AppSizes.sm),
            itemBuilder: (_, _) {
              return Container(
                width: 96,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                ),
                padding: const EdgeInsets.all(AppSizes.sm),
                child: ClipOval(
                  child: Image.asset(AppImages.foodTest, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
