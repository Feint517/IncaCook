import 'package:flutter/material.dart';
import 'package:vinted_v2/core/constants/colors.dart';

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({
    super.key,
    this.color = AppColors.secondary,
    this.opacity = 0.12,
    this.height = 1,
  });

  final Color color;
  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color.withValues(alpha: opacity),
    );
  }
}
