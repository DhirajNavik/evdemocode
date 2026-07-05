import 'package:flutter/material.dart';

class AppPalettes {
  static const primaryColor = Color(0xff3FD175);
  static const secondaryColor = Color(0xff288E45);
  static const loadingBgColor = Color(0xff144021);
  static const loadingShadowColor = Color(0xff10351A);
  static const blackColor = Colors.black;
  static const iconColor = Color(0xff868686);
  static const backgroundColor = Color(0xff151515);
  static const cardColor = Color(0xff313131);
  static const cardInsetShadowOne = Color(0xFF4A4A4A);
  static const cardInsetShadowTwo = Color(0xFF1E1E1E);
  static const primaryTextColor = Color(0xffFFFFFF);
  static const secondaryTextColor = Color(0xff666666);
  static const Color transparentColor = Colors.transparent;
  static const whiteColor = Color(0xFFFFFFFF);
  static const tailLightColor = Colors.deepOrange;
  static const greyColor = Colors.grey;
  static const glowColor = Colors.cyanAccent;
}

extension ColorWithOpacity on Color {
  Color withOpacityExt(double val) {
    return withValues(alpha: val);
  }
}
