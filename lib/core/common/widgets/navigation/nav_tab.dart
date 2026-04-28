import 'package:flutter/material.dart';

class NavTab {
  const NavTab({
    required this.icon,
    required this.label,
    required this.screen,
  });

  final IconData icon;
  final String label;
  final Widget screen;
}
