import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveHelper {
  ResponsiveHelper._();
  static DeviceType getDeviceType(BuildContext context) {
    return switch (MediaQuery.sizeOf(context).width) {
      >= 700 => DeviceType.desktop,
      >= 500 => DeviceType.tablet,
      _ => DeviceType.mobile,
    };
  }
}
