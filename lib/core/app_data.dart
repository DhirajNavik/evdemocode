import 'package:animations/core/app_images.dart';
import 'package:animations/core/app_palettes.dart';
import 'package:flutter/painting.dart';

class AppData {
  AppData._();

  static final List<IconData> icons = [
    IconData(name: AppImages.icon_1, color: AppPalettes.iconColor),
    IconData(name: AppImages.icon_2, color: AppPalettes.iconColor),
    IconData(name: AppImages.icon_3, color: AppPalettes.primaryColor),
    IconData(name: AppImages.icon_4, color: AppPalettes.iconColor),
  ];
}

class IconData {
  final String name;
  final Color color;
  const IconData({required this.name, required this.color});
}
