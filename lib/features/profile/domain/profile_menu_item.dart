import 'package:flutter/material.dart';

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.icon,
    required this.title,
    this.trailingText,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final bool showChevron;
  final VoidCallback? onTap;
}
