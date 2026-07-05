import 'dart:math';
import 'package:animations/core/app_palettes.dart';
import 'package:animations/utils/bubble_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/bubble_model.dart';

class AnimatedProgress extends StatefulWidget {
  final AnimationController controller;
  final ValueListenable<int> progress;
  const AnimatedProgress({
    super.key,
    required this.controller,
    required this.progress,
  });

  @override
  State<AnimatedProgress> createState() => _AnimatedProgressState();
}

class _AnimatedProgressState extends State<AnimatedProgress> {
  final List<Bubble> _bubbles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 25; i++) {
      _bubbles.add(_createBubble());
    }
  }

  Bubble _createBubble() {
    final size = _random.nextDouble() * 8 + 4;
    return Bubble(
      x: _random.nextDouble().clamp(0.02, 0.98),
      y: _random.nextDouble().clamp(0.12, 0.88),
      isOpposite: _random.nextBool(),
      color: AppPalettes.primaryColor.withValues(alpha: _random.nextDouble() * 1 + 0.5),
      size: size,
      speed: size * 0.0002,
    );
  }

  void _updateBubbles() {
    for (var bubble in _bubbles) {
      var val = bubble.x;
      if (bubble.isOpposite) {
        if (val <= 0.02) {
          val = 0;
          bubble.isOpposite = !bubble.isOpposite;
        }
        val -= bubble.speed;
      } else {
        if (val >= 0.98) {
          val = 1;
          bubble.isOpposite = !bubble.isOpposite;
        }
        val += bubble.speed;
      }
      bubble.x = val.clamp(0.02, 0.98);
      bubble.y += sin(widget.controller.value * 2 * pi + bubble.x * 10) * 0.001;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            _updateBubbles();
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              tween: Tween(end: widget.progress.value / 100),
              builder: (context, progress, _) {
                return CustomPaint(
                  painter: BubblePainter(_bubbles),
                  size: Size(constraints.maxWidth * progress, 55),
                );
              },
            );
          },
        );
      },
    );
  }
}
