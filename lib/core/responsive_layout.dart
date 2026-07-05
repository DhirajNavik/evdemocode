import 'package:animations/core/responsive_helper.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    switch (ResponsiveHelper.getDeviceType(context)) {
      case DeviceType.desktop:
        return desktop ?? tablet;

      case DeviceType.tablet:
        return tablet;

      case DeviceType.mobile:
        return mobile;
    }
  }
}
