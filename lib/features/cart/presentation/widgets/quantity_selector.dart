import 'package:flutter/material.dart';
import 'package:vinted_v2/core/constants/colors.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.minQuantity = 1,
  });

  final int quantity;
  final int minQuantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final decrementEnabled = quantity > minQuantity;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RoundButton(
          icon: Icons.remove_rounded,
          background: AppColors.white,
          foreground: decrementEnabled
              ? AppColors.secondary
              : AppColors.grey.withValues(alpha: 0.5),
          bordered: true,
          onTap: decrementEnabled ? onDecrement : null,
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _RoundButton(
          icon: Icons.add_rounded,
          background: AppColors.secondary,
          foreground: AppColors.white,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
    this.bordered = false,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: bordered
              ? Border.all(
                  color: AppColors.grey.withValues(alpha: 0.2),
                  width: 1,
                )
              : null,
        ),
        child: Icon(icon, color: foreground, size: 18),
      ),
    );
  }
}
