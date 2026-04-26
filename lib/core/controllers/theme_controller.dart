import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final _storage = GetStorage();
  final _key = 'isDarkMode';

  /// Get the theme mode from storage or system default
  ThemeMode get themeMode =>
      _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load theme from local storage
  bool _loadThemeFromBox() {
    return _storage.read(_key) ?? false;
  }

  /// Save theme to local storage
  _saveThemeToBox(bool isDarkMode) {
    _storage.write(_key, isDarkMode);
  }

  /// Switch between light and dark themes
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
