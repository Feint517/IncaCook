import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vinted_v2/core/common/widgets/custon_shapes/container/circular_image.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.imagePath,
    required this.selected,
    this.onTap,
  });

  final String label;
  final String imagePath;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double pillHeight = 35;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: selected ? AppColors.accent : AppColors.secondary,
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        height: pillHeight,
        padding: const EdgeInsets.only(right: AppSizes.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondary : AppColors.accent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircularImage(image: imagePath),
            const Gap(AppSizes.sm),
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
