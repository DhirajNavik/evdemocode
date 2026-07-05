
import 'package:flutter/material.dart';

import '../model/bubble_model.dart';

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    final rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(100),
    );
  
    canvas.clipRRect(rRect);
    canvas.save();

    for (final bubble in bubbles) {
      final paint = Paint()
        ..color = bubble.color
        ..style = .stroke
        ..strokeWidth = 2.2;

      final highlightPaint = Paint()..color = bubble.color;

      final dx = bubble.x * size.width;
      final dy = bubble.y * size.height;

      canvas.drawCircle(Offset(dx, dy), bubble.size, paint);

      canvas.drawCircle(
        Offset(dx - bubble.size * -0.3, dy - bubble.size * -0.5),
        bubble.size * 0.2,
        highlightPaint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
}
