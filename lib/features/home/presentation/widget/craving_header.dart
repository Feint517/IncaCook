import 'package:flutter/material.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';

class CravingHeader extends StatelessWidget {
  const CravingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      height: 1.1,
    );

    return Text.rich(
      TextSpan(
        style: base,
        children: [
          TextSpan(
            text: '${AppTexts.homeCravingPart1} ',
            style: base?.copyWith(color: AppColors.textPrimary),
          ),
          TextSpan(
            text: '${AppTexts.homeCravingPart2} ',
            style: base?.copyWith(
              color: AppColors.grey.withValues(alpha: 0.55),
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: AppTexts.homeCravingPart3,
            style: base?.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
