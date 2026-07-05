import 'package:flutter/material.dart';

class StraightLine extends CustomPainter {
  final double progress;
  final Color color;
  const StraightLine(this.progress, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final wire = Paint()
      ..color = Colors.grey.withValues(alpha: 0.4)
      ..strokeWidth = 6;

    final glow = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 4);
    canvas.drawCircle(Offset(size.width * progress, size.height), 4, glow);

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(0, size.height),
      wire,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
