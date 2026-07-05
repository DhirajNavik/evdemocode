import 'dart:ui' as ui;
import 'package:animations/core/app_palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageCanvasPainter extends CustomPainter {
  final ui.Image image;
  final double progress;
  final double blink;
  final double fade;
  ImageCanvasPainter(this.image, {required this.progress, required this.blink, required this.fade});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint();

    final glow = Paint()
      ..color = AppPalettes.glowColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final tailGlow = Paint()
      ..color = AppPalettes.tailLightColor.withValues(alpha: 0.2 + blink * 0.8)
      ..strokeWidth = 6 + blink * 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2 + blink * 8);

    paint.color =AppPalettes.greyColor.withValues(alpha: 0.8);
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..colorFilter = ColorFilter.matrix(saturationMatrix(fade)),
    );

    path.moveTo(size.width / 2.03, size.height / 2.3);

    path.quadraticBezierTo(
      size.width / 2.6,
      size.height / 5 * 3,
      size.width / 5 * 2.4,
      size.height / 5 * 3.5,
    );
    path.quadraticBezierTo(
      size.width / 5 * 2.95,
      size.height / 5 * 4,
      size.width / 2 * 1.21,
      size.height / 4 * 3.5,
    );
    path.quadraticBezierTo(
      size.width / 1.6,
      size.height,
      size.width / 4 * 2.9,
      size.height * 0.98,
    );
    path.quadraticBezierTo(
      size.width / 4 * 3.2,
      size.height * 0.95,
      size.width / 4 * 3.49,
      size.height * 0.965,
    );
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height * 0.95,
    );

    canvas.drawPath(path, paint);

    if (progress == 1) {
      canvas.drawLine(
        Offset(size.width / 1.6, size.height / 2.14),
        Offset(size.width / 1.75, size.height / 2.14),
        tailGlow,
      );
      canvas.drawLine(
        Offset(size.width / 1.77, size.height / 2.14),
        Offset(size.width / 1.73, size.height / 2.4),
        tailGlow,
      );
      canvas.drawLine(
        Offset(size.width / 1.72, size.height / 2.4),
        Offset(size.width / 1.5, size.height / 2.4),
        tailGlow,
      );
      canvas.drawLine(
        Offset(size.width / 1.49, size.height / 2.4),
        Offset(size.width / 1.46, size.height / 2.25),
        tailGlow,
      );

      canvas.drawLine(
        Offset(size.width / 2 * 1.86, size.height / 2.16),
        Offset(size.width / 2 * 1.82, size.height / 2.16),
        tailGlow,
      );
      canvas.drawLine(
        Offset(size.width / 2 * 1.86, size.height / 2.27),
        Offset(size.width / 2 * 1.78, size.height / 2.27),
        tailGlow,
      );
      canvas.drawLine(
        Offset(size.width / 2 * 1.85, size.height / 2.4),
        Offset(size.width / 2 * 1.78, size.height / 2.4),
        tailGlow,
      );
    } else {
      final metric = path.computeMetrics().single;

      final tangent = metric.getTangentForOffset(
        (metric.length) * (1 - progress),
      );
      if (tangent != null) {
        const length = 18.0;

        final direction = tangent.vector;

        final start = Offset(
          tangent.position.dx - direction.dx * length / 2,
          tangent.position.dy - direction.dy * length / 2,
        );

        final end = Offset(
          tangent.position.dx + direction.dx * length / 2,
          tangent.position.dy + direction.dy * length / 2,
        );
        canvas.drawLine(start, end, glow);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension AssetToUiImage on String {
  Future<ui.Image> toUiImage() async {
    final ui.ImmutableBuffer buffer = await rootBundle.loadBuffer(this);
    final ui.Codec codec = await ui.instantiateImageCodecFromBuffer(buffer);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}

List<double> saturationMatrix(double saturation) {

  final invSat = 1 - saturation;

  final r = 0.2126 * invSat;
  final g = 0.7152 * invSat;
  final b = 0.0722 * invSat;

  return [
    r + saturation,
    g,
    b,
    0,
    0,
    r,
    g + saturation,
    b,
    0,
    0,
    r,
    g,
    b + saturation,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
}
