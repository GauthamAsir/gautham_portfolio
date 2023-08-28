import 'package:flutter/material.dart';

import 'colors.dart';
import 'test_styles.dart';
import 'text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.defaultFontFamily,
      primaryColor: CustomColors.primaryColor,
      colorScheme: ColorScheme.dark(
        primary: CustomColors.primaryColor,
        secondary: CustomColors.secondaryColor,
        background: CustomColors.whiteColor,
      ),
      scaffoldBackgroundColor: CustomColors.primaryColor,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: CustomColors.whiteColor,
        titleTextStyle: AppTextStyles.h2,
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: CustomColors.primaryColor,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: ColorScheme.light(
        primary: CustomColors.primaryColor,
        secondary: CustomColors.secondaryColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: CustomColors.whiteColor,
      ),
    );
  }
}
