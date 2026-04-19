import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/features/cart/domain/cart_item.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    this.onMoreTap,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = AppSizes.cardRadiusLg * 1.3;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: const SizedBox.shrink(),
      secondaryBackground: _SwipeDeleteBackground(radius: cardRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(cardRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* food image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
              child: Image.asset(
                item.imagePath,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(AppSizes.sm),

            //* info + quantity
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? title row with "…" menu
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                              ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onMoreTap,
                        child: const SizedBox(
                          width: 28,
                          height: 20,
                          child: Icon(
                            Iconsax.more,
                            size: 18,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //? description
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                      height: 1.3,
                    ),
                  ),
                  const Gap(AppSizes.xs),

                  //? price + quantity selector
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _PriceText(price: item.price),
                      const Spacer(),
                      QuantitySelector(
                        quantity: item.quantity,
                        onDecrement: onDecrement,
                        onIncrement: onIncrement,
                      ),
                    ],
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

class _PriceText extends StatelessWidget {
  const _PriceText({required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          price.toStringAsFixed(2),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _SwipeDeleteBackground extends StatelessWidget {
  const _SwipeDeleteBackground({required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
      child: const Icon(
        Iconsax.trash,
        color: Color(0xFFE53935),
        size: 26,
      ),
    );
  }
}
