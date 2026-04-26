import 'package:flutter/material.dart';

class AppColorExtensions extends ThemeExtension<AppColorExtensions> {
  const AppColorExtensions({
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color? success;
  final Color? warning;
  final Color? info;

  @override
  ThemeExtension<AppColorExtensions> copyWith({
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppColorExtensions(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppColorExtensions> lerp(
    covariant ThemeExtension<AppColorExtensions>? other,
    double t,
  ) {
    if (other is! AppColorExtensions) {
      return this;
    }
    return AppColorExtensions(
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      info: Color.lerp(info, other.info, t),
    );
  }
}
