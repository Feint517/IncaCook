import 'package:flutter/material.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/chip_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/text_field_theme.dart';
import 'package:vinted_v2/core/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._(); //?private constructor, to make sure that it's not used again and again

  static ThemeData ligtTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
    textTheme: CustomTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
    textTheme: CustomTextTheme.darkTextTheme,
  );
}
