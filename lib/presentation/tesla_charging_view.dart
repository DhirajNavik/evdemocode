import 'dart:async';
import 'dart:ui' as ui;
import 'package:animations/core/app_images.dart';
import 'package:animations/utils/image_painter.dart';
import 'package:flutter/material.dart';

class TeslaChargingView extends StatefulWidget {
  final AnimationController controller;

  const TeslaChargingView({super.key, required this.controller});

  @override
  State<TeslaChargingView> createState() => _TeslaChargingViewState();
}

class _TeslaChargingViewState extends State<TeslaChargingView>
    with TickerProviderStateMixin {
  late Timer? _timer;
  late final Animation<double> progress;
  late final AnimationController fadeController;
  late final Animation<double> fadeAnimation;
  late final AnimationController blinkController;

  @override
  void initState() {
    super.initState();

    blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    widget.controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        blinkController.repeat(reverse: true);
        fadeController.forward();
        _timer = Timer(Duration(milliseconds: 500), () {
          blinkController.reverse();
          fadeController.reverse();
          widget.controller.forward(from: 0);
        });
      } else if (status == AnimationStatus.dismissed) {
        blinkController.reverse();
        fadeController.reverse();
        _timer?.cancel();
      }
    });

    progress = CurvedAnimation(parent: widget.controller, curve: Curves.easeIn);
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    blinkController.dispose();
    fadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return FutureBuilder<ui.Image>(
          future: AppImages.teslaPng.toUiImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxWidth * 0.6,
              );
            }
            return AnimatedBuilder(
              animation: Listenable.merge([
                widget.controller,
                blinkController,
                fadeController,
              ]),
              builder: (context, child) {
                return CustomPaint(
                  painter: ImageCanvasPainter(
                    snapshot.data!,
                    blink: blinkController.value,
                    fade: fadeAnimation.value,
                    progress: progress.value,
                  ),
                  size: Size(constraints.maxWidth, constraints.maxWidth * 0.6),
                );
              },
            );
          },
        );
      },
    );
  }
}
