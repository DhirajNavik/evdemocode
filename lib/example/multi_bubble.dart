import 'dart:math';
import 'package:flutter/material.dart';

class MultiBubbleAnimation extends StatefulWidget {
  const MultiBubbleAnimation({super.key});

  @override
  State<MultiBubbleAnimation> createState() => _MultiBubbleAnimationState();
}

class _MultiBubbleAnimationState extends State<MultiBubbleAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Bubble> _bubbles = [];
  final _random = Random();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    // Create initial bubbles
    for (int i = 0; i < 20; i++) {
      _bubbles.add(createBubble());
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Bubble createBubble() {
    final size = _random.nextDouble() * 30 + 10;
    return Bubble(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      isOpposite: _random.nextBool(),
      color: Colors.blue.withValues(alpha: _random.nextDouble() * 0.7 + 0.3),
      size: size,
      speed: size * 0.0001,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(title: Text("Multi Bubbles")),
      body: Column(
        children: [
          // AnimatedProgress(),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, _) {
                for (var bubble in _bubbles) {
                  if (bubble.isOpposite) {
                    if (bubble.y <= 0) {
                      bubble.y = 0;
                      bubble.isOpposite = !bubble.isOpposite;
                    }
                    bubble.y -= bubble.speed;
                  } else {
                    if (bubble.y >= 1) {
                      bubble.y = 1;
                      bubble.isOpposite = !bubble.isOpposite;
                    }
                    bubble.y += bubble.speed;
                  }
                  bubble.x +=
                      sin(_controller.value * 2 * pi + bubble.y + 10) * 0.0010;
                }
            
                return CustomPaint(
                  painter: CustomBubble(bubbles: _bubbles),
                  size: Size.infinite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBubble extends CustomPainter {
  final List<Bubble> bubbles;
  const CustomBubble({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final paint = Paint()
        ..color = bubble.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.size,
        paint,
      );

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Bubble {
  double x;
  double y;
  bool isOpposite;
  final Color color;
  final double size;
  final double speed;

  Bubble({
    required this.x,
    required this.y,
    required this.isOpposite,
    required this.color,
    required this.size,
    required this.speed,
  });
}
