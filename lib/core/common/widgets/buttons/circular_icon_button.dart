import 'package:flutter/material.dart';
import 'package:vinted_v2/core/constants/sizes.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({super.key, 
    required this.icon,
    this.size = 34,
    required this.onTap,
    required this.background,
    required this.borderColor,
    required this.iconColor,
  });

  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final Color background;
  final Color borderColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, color: iconColor, size: AppSizes.iconSm + 2),
      ),
    );
  }
}