import 'package:animations/core/responsive_layout.dart';
import 'package:animations/presentation/home_desktop_view.dart';
import 'package:animations/presentation/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: .dark(),
      home: ResponsiveLayout(
        mobile: const HomeView(),
        tablet: const HomeView(),
        desktop: const HomeDesktopView(),
      ),
    );
  }
}
