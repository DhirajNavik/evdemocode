import 'package:animations/core/app_palettes.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get bodySmall =>
      TextStyle(color: AppPalettes.iconColor, fontSize: 14, fontWeight: .w500);
  static TextStyle get bodyMedium =>
      TextStyle(color: AppPalettes.iconColor, fontSize: 16, fontWeight: .w500);
  static TextStyle get bodyLarge =>
      TextStyle(color: AppPalettes.whiteColor, fontSize: 18, fontWeight: .w500);
  static TextStyle get titleLarge =>
      TextStyle(color: AppPalettes.whiteColor, fontSize: 22, fontWeight: .w800);
  static TextStyle get headlineMedium => TextStyle(
    fontSize: 28,
    fontWeight: .bold,
    color: AppPalettes.primaryTextColor,
  );

  
}
