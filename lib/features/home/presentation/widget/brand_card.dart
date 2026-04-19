import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/features/home/domain/brand.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.brand, this.onTap});

  final Brand brand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        ),
        child: Row(
          children: [
            //* square logo block
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(brand.imagePath, fit: BoxFit.cover),
            ),
            const Gap(AppSizes.md),

            //* text info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.verify5,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const Gap(4),
                      Flexible(
                        child: Text(
                          brand.tagline,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ),
                    ],
                  ),
                  const Gap(2),
                  Text(
                    brand.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(Iconsax.clock, size: 14, color: AppColors.grey),
                      const Gap(4),
                      Text(
                        '${brand.minDeliveryMinutes}-${brand.maxDeliveryMinutes} mins',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //* rating pill
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Iconsax.star1, color: Color(0xFFFFC107), size: 14),
                  const Gap(4),
                  Text(
                    brand.rating.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
