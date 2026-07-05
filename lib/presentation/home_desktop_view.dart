import 'package:animations/presentation/home_view.dart';
import 'package:flutter/material.dart';

class HomeDesktopView extends StatelessWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const .symmetric(vertical: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: HomeView(),
          ),
        ),
      ),
    );
  }
}
