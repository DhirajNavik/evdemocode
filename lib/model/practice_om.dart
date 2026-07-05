
import 'package:flutter/material.dart';

class CustomSymbol extends CustomPainter {
  final double progress;
  final Color glowColor;

  CustomSymbol({required this.progress, required this.glowColor});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final paint = Paint();

    paint.color = Colors.blue;
    paint.strokeWidth = 10;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;

    final glow = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Build your path...
    path.moveTo(size.width / 5, size.height / 4);

    path.quadraticBezierTo(
      size.width / 5 * 2 + 10,
      0,
      size.width / 2 + 20,
      size.height / 4,
    );

    path.quadraticBezierTo(
      size.width / 5 * 3,
      size.height / 8 * 3,
      size.width / 6 * 2.2,
      size.height / 2,
    );

    path.quadraticBezierTo(
      size.width / 5 * 3,
      size.height / 5 * 3,
      size.width / 1.9,
      size.height / 4 * 3,
    );

    path.quadraticBezierTo(
      size.width / 5 * 2,
      size.height,
      size.width / 5,
      size.height / 4 * 3,
    );

    path.moveTo(size.width / 5 * 1.95, size.height / 1.99);

    path.quadraticBezierTo(
      size.width / 5 * 4,
      size.height / 6 * 2,
      size.width / 6 * 5,
      size.height / 5 * 3,
    );

    path.quadraticBezierTo(
      size.width / 7 * 6,
      size.height / 8 * 7,
      size.width / 6 * 4,
      size.height / 8 * 6.4,
    );
    path.quadraticBezierTo(
      size.width / 1.8,
      size.height / 4 * 3,
      size.width / 4 * 2.5,
      size.height / 8 * 5.5,
    );

    path.moveTo(size.width / 7 * 4, size.height / 6);

    path.quadraticBezierTo(
      size.width / 7 * 5,
      size.height / 2.5,
      size.width / 9 * 8,
      size.height / 5,
    );

    canvas.drawCircle(
      Offset(size.width / 8 * 5.9, size.height / 5),
      20,
      paint..style = PaintingStyle.fill,
    );
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);

    final metrics = path.computeMetrics().toList();

    for (final metric in metrics) {
      final tangent = metric.getTangentForOffset(metric.length * progress);

      if (tangent != null) {
        canvas.drawCircle(tangent.position, 8, glow);
      }
    }
  }

  //divide 8part used 3part
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
