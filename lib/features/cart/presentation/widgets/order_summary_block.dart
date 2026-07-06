import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:incacook/core/common/widgets/misc/horizontal_separator.dart';
import 'package:incacook/core/common/widgets/misc/price_display.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';

class OrderSummaryBlock extends StatelessWidget {
  const OrderSummaryBlock({
    super.key,
    required this.subtotal,
    this.shipping,
  });

  final double subtotal;

  /// Delivery fee, or **null** at the cart stage — the buyer hasn't chosen
  /// delivery vs pickup yet, so we show a "calculated next step" hint instead
  /// of a made-up fee/total. The real breakdown is on the summary screen.
  final double? shipping;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800);
    final shipping = this.shipping;

    // Cart stage: no fulfillment choice yet → don't invent a delivery fee/total.
    if (shipping == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppTexts.cartOrderSummaryTitle, style: titleStyle),
          const Gap(AppSizes.md),
          _SummaryRow(label: AppTexts.cartSubtotalLabel, value: subtotal),
          const Gap(AppSizes.sm),
          _HintRow(
            label: AppTexts.cartShippingLabel,
            hint: AppTexts.cartFeesDeferredHint,
          ),
        ],
      );
    }

    // 5% platform fee on (subtotal + delivery), matching the backend so the
    // total shown equals what Stripe charges.
    final platformFee = (subtotal + shipping) * AppTexts.platformFeeRate;
    final total = subtotal + shipping + platformFee;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppTexts.cartOrderSummaryTitle, style: titleStyle),
        const Gap(AppSizes.md),
        _SummaryRow(label: AppTexts.cartSubtotalLabel, value: subtotal),
        const Gap(AppSizes.sm),
        _SummaryRow(label: AppTexts.cartShippingLabel, value: shipping),
        const Gap(AppSizes.sm),
        _SummaryRow(label: AppTexts.cartPlatformFeeLabel, value: platformFee),
        const Gap(AppSizes.md - 4),
        const HorizontalSeparator(),
        const Gap(AppSizes.md - 4),
        _SummaryRow(
          label: AppTexts.cartTotalLabel,
          value: total,
          emphasize: true,
        ),
      ],
    );
  }
}

/// A summary row whose value is a text hint (e.g. "calculated next step")
/// rather than a price — used when a fee isn't known yet.
class _HintRow extends StatelessWidget {
  const _HintRow({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          hint,
          style: textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final double value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = emphasize
        ? Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          );
    return Row(
      children: [
        Text(label, style: labelStyle),
        const Spacer(),
        PriceDisplay(price: value, currencySize: 15, priceSize: 15),
      ],
    );
  }
}
