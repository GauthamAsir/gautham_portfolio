import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static String defaultFontFamily = poppinsFontFamily;

  static String poppinsFontFamily = 'Poppins';

  /// Text style for body
  static TextStyle bodyLg = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: defaultFontFamily);

  static TextStyle body = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, fontFamily: defaultFontFamily);

  static TextStyle bodySm = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w300, fontFamily: defaultFontFamily);

  static TextStyle bodyXs = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w300, fontFamily: defaultFontFamily);

  /// Text style for heading

  static TextStyle h1 = TextStyle(
      fontSize: 24, fontWeight: FontWeight.w700, fontFamily: defaultFontFamily);

  static TextStyle h2 = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, fontFamily: defaultFontFamily);

  static TextStyle h3 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, fontFamily: defaultFontFamily);

  static TextStyle h4 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, fontFamily: defaultFontFamily);
}
