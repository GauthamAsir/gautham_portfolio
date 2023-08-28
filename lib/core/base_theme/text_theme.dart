import 'package:flutter/material.dart';

import 'colors.dart';
import 'test_styles.dart';

class TextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySm,
      titleSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  /// Dark text theme

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: CustomColors.whiteColor),
      bodyMedium: AppTextStyles.body.copyWith(color: CustomColors.whiteColor),
      titleMedium:
          AppTextStyles.bodySm.copyWith(color: CustomColors.whiteColor),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: CustomColors.whiteColor),
      displayLarge: AppTextStyles.h1.copyWith(color: CustomColors.whiteColor),
      displayMedium: AppTextStyles.h2.copyWith(color: CustomColors.whiteColor),
      displaySmall: AppTextStyles.h3.copyWith(color: CustomColors.whiteColor),
      headlineMedium: AppTextStyles.h4.copyWith(color: CustomColors.whiteColor),
    );
  }

  /// Primary text theme

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge:
          AppTextStyles.bodyLg.copyWith(color: CustomColors.primaryColor),
      bodyMedium: AppTextStyles.body.copyWith(color: CustomColors.primaryColor),
      titleMedium:
          AppTextStyles.bodySm.copyWith(color: CustomColors.primaryColor),
      titleSmall:
          AppTextStyles.bodyXs.copyWith(color: CustomColors.primaryColor),
      displayLarge: AppTextStyles.h1.copyWith(color: CustomColors.primaryColor),
      displayMedium:
          AppTextStyles.h2.copyWith(color: CustomColors.primaryColor),
      displaySmall: AppTextStyles.h3.copyWith(color: CustomColors.primaryColor),
      headlineMedium:
          AppTextStyles.h4.copyWith(color: CustomColors.primaryColor),
    );
  }
}
