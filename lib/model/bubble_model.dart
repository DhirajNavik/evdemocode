import 'package:flutter/material.dart';

class Bubble {
  double x;
  double y;
  bool isOpposite;
  final double size;
  final double speed;
  final Color color;

  Bubble({
    required this.x,
    required this.y,
    required this.isOpposite,
    required this.size,
    required this.speed,
    required this.color,
  });
}
