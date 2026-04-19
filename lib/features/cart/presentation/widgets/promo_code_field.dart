import 'package:flutter/material.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';

class PromoCodeField extends StatelessWidget {
  const PromoCodeField({super.key, this.controller, this.onApply});

  final TextEditingController? controller;
  final ValueChanged<String>? onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSizes.md, 4, 4, 4),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: AppColors.secondary,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                isCollapsed: true,
                hintText: AppTexts.cartPromoHint,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onApply?.call(controller?.text ?? ''),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.lg,
                vertical: AppSizes.sm + 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                AppTexts.cartApply,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
