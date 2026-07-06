import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/utils/popups/blurred_modal_sheet.dart';
import 'package:incacook/core/widgets/effects/frosted_surface.dart';
import 'package:incacook/features/seller/data/seller_orders_repository.dart';

/// Opens the seller-facing order details for [order] as a frosted bottom
/// sheet. Renders the full breakdown the list cards can't fit: every line
/// item with quantity + unit/line price, per-item and order-level notes,
/// fulfilment mode, and the buyer-total / seller-earnings split.
Future<void> showSellerOrderDetails(
  BuildContext context,
  SellerOrderSummary order,
) {
  return showBlurredModalBottomSheet<void>(
    context: context,
    builder: (_) => SellerOrderDetailsSheet(order: order),
  );
}

class SellerOrderDetailsSheet extends StatelessWidget {
  const SellerOrderDetailsSheet({super.key, required this.order});

  final SellerOrderSummary order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final dateLabel = DateFormat('d MMM y', 'fr_FR').format(order.placedAt);
    final timeLabel = DateFormat.jm('fr_FR').format(order.placedAt);
    final fulfillmentLabel = order.fulfillmentChoice == 'PICKUP'
        ? AppTexts.sellerOrderDetailsFulfillmentPickup
        : AppTexts.sellerOrderDetailsFulfillmentDelivery;

    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FrostedSurface(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          padding: const EdgeInsets.fromLTRB(
            AppSizes.lg,
            AppSizes.md,
            AppSizes.lg,
            AppSizes.lg,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle.
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSizes.md),
                    decoration: BoxDecoration(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Iconsax.box, color: scheme.onSurface, size: 24),
                    const Gap(AppSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.sellerOrderDetailsTitle,
                            style: textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '#${order.orderNumber}',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$dateLabel · $timeLabel',
                      style: textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const Gap(AppSizes.md),
                _InfoRow(
                  icon: order.fulfillmentChoice == 'PICKUP'
                      ? Iconsax.shop
                      : Iconsax.truck,
                  label: AppTexts.sellerOrderDetailsFulfillmentLabel,
                  value: fulfillmentLabel,
                ),
                const Gap(AppSizes.md),
                Text(
                  AppTexts.sellerOrderDetailsItemsLabel,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(AppSizes.sm),
                Flexible(
                  child: order.items.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.md,
                          ),
                          child: Text(
                            AppTexts.sellerOrderDetailsNoItems,
                            style: textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: order.items.length,
                          separatorBuilder: (_, _) => Divider(
                            height: AppSizes.md,
                            color: scheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                          itemBuilder: (_, i) => _ItemRow(item: order.items[i]),
                        ),
                ),
                if ((order.note ?? '').trim().isNotEmpty) ...[
                  const Gap(AppSizes.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                        children: [
                          TextSpan(
                            text: '${AppTexts.sellerOrderNotePrefix} ',
                            style: textTheme.bodySmall?.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(text: order.note!.trim()),
                        ],
                      ),
                    ),
                  ),
                ],
                const Gap(AppSizes.md),
                Divider(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                const Gap(AppSizes.sm),
                _TotalRow(
                  label: AppTexts.sellerOrderDetailsBuyerTotalLabel,
                  cents: order.buyerTotalCents,
                ),
                const Gap(AppSizes.xs),
                _TotalRow(
                  label: AppTexts.sellerOrderDetailsEarningsLabel,
                  cents: order.sellerEarningsCents,
                  emphasized: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: scheme.onSurfaceVariant),
        const Gap(AppSizes.sm),
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});

  final SellerOrderItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final lineTotal = item.unitPriceEuros * item.quantity;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'x${item.quantity}',
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Gap(AppSizes.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.listingName,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${item.unitPriceEuros.toStringAsFixed(2)} € / unité',
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              if ((item.note ?? '').trim().isNotEmpty) ...[
                const Gap(AppSizes.xs),
                Text(
                  item.note!.trim(),
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Gap(AppSizes.sm),
        Text(
          '${lineTotal.toStringAsFixed(2)} €',
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.cents,
    this.emphasized = false,
  });

  final String label;
  final int cents;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final style = emphasized
        ? textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: scheme.primary,
          )
        : textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant);
    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text('${(cents / 100.0).toStringAsFixed(2)} €', style: style),
      ],
    );
  }
}
