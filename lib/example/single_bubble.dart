import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class SingleBubbleAnimation extends StatefulWidget {
  const SingleBubbleAnimation({super.key});

  @override
  State<SingleBubbleAnimation> createState() => _SingleBubbleAnimationState();
}

class _SingleBubbleAnimationState extends State<SingleBubbleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SingleBubble _bubble;
  final Random _random = Random();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _bubble = _createBubble();
    super.initState();
  }

  SingleBubble _createBubble() {
    final size = _random.nextDouble() * 30 + 10;
    return SingleBubble(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      size: size,
      speed: _random.nextDouble() * 0.02 + 0.1,
      color: Colors.blue.withValues(alpha: (_random.nextDouble() * 0.7 + 0.3)),
      movingUp: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Floating Bubbles')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) {
          if (_bubble.movingUp) {
            _bubble.y -= _bubble.speed * 0.012;

            if (_bubble.y <= 0) {
              _bubble.y = 0;
              _bubble.movingUp = false;
            }
          } else {
            _bubble.y += _bubble.speed * 0.012;

            if (_bubble.y >= 1.0) {
              _bubble.y = 1.0;
              _bubble.movingUp = true;
            }
          dev.log("y${_bubble.y.toString()}");

          }
          _bubble.x += sin(_controller.value * 2 * pi + _bubble.y * 10) * 0.0015;
          dev.log("x${_bubble.x.toString()}");
          return CustomPaint(
            painter: BubblePainter(_bubble),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class SingleBubble {
  double x;
  double y;
  final double speed;
  final double size;
  final Color color;
  bool movingUp;

  SingleBubble({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.movingUp,
  });
}

class BubblePainter extends CustomPainter {
  final SingleBubble bubble;

  BubblePainter(this.bubble);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bubble.color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(bubble.x * size.width, bubble.y * size.height),
      bubble.size,
      paint,
    );

    // Add highlight to bubble
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(
        bubble.x * size.width - bubble.size * 0.3,
        bubble.y * size.height - bubble.size * 0.3,
      ),
      bubble.size * 0.2,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
