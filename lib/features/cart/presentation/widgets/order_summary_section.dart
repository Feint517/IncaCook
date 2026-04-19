import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vinted_v2/app.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/core/utils/device_utils.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.subTotal,
    required this.shipping,
  });

  final double subTotal;
  final double shipping;

  double get _total => subTotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSizes.md,
        AppSizes.md,
        AppSizes.md,
        DeviceUtils.getBottomNavigationBarHeight() / 1.5,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.cartOrderSummary,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(AppSizes.md),
          _SummaryRow(label: AppTexts.cartSubTotal, amount: subTotal),
          const Gap(AppSizes.sm),
          _SummaryRow(label: AppTexts.cartShipping, amount: shipping),
          const Gap(AppSizes.md),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.grey.withValues(alpha: 0.2),
          ),
          const Gap(AppSizes.md),
          _SummaryRow(
            label: AppTexts.cartTotal,
            amount: _total,
            emphasized: true,
          ),
          const Gap(AppSizes.md),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(AppTexts.cartContinuePay),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.amount,
    this.emphasized = false,
  });

  final String label;
  final double amount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: emphasized ? AppColors.textPrimary : AppColors.grey,
      fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
    );
    final amountStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: emphasized ? FontWeight.w800 : FontWeight.w600,
    );

    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text('\$${amount.toStringAsFixed(2)}', style: amountStyle),
      ],
    );
  }
}
