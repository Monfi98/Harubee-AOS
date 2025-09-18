import 'package:flutter/material.dart';
import 'dart:math';

class RoundedHexagonPainter extends CustomPainter {
  final double width;
  final double borderRadius;
  final Color color;

  final double? borderWidth;
  final Color? borderColor;

  const RoundedHexagonPainter({
    required this.width,
    required this.borderRadius,
    required this.color,
    this.borderWidth,
    this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = width / 2;
    final center = Offset(width / 2, width / 2);
    const angle = (pi * 2) / 6;
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    Offset? prevEnd;

    for (int i = 0; i < 6; i++) {
      final currAngle = angle * i;
      final r = borderRadius;
      final d = 2 * sqrt(3.0) * r / 3;
      final currX = radius * cos(currAngle) + center.dx;
      final currY = radius * sin(currAngle) + center.dy;
      final dx = d * cos(currAngle + pi) + currX;
      final dy = d * sin(currAngle + pi) + currY;
      final oval = Rect.fromCircle(center: Offset(dx, dy), radius: r);

      final arcStartAngle = currAngle - pi / 6;
      final arcEndAngle = currAngle + pi / 6;

      final arcStartX = dx + r * cos(arcStartAngle);
      final arcStartY = dy + r * sin(arcStartAngle);
      final arcEndX = dx + r * cos(arcEndAngle);
      final arcEndY = dy + r * sin(arcEndAngle);

      final arcStart = Offset(arcStartX, arcStartY);
      final arcEnd = Offset(arcEndX, arcEndY);

      if (prevEnd == null) {
        path.moveTo(arcStart.dx, arcStart.dy);
      } else {
        path.lineTo(arcStart.dx, arcStart.dy);
      }

      path.arcTo(oval, arcStartAngle, pi / 3, false);
      prevEnd = arcEnd;
    }

    path.close();

    canvas.drawPath(path, paint);

    if (borderColor != null && borderWidth != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth!;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
