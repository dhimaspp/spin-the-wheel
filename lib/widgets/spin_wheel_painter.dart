import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_widget.dart';

class SpinWheelPainter extends CustomPainter {
  final List<SpinItem> items;

  SpinWheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    const spaceBetweenItems = 0; // Adjust this value to set the desired space between items
    final totalSections = items.length;
    const totalAngle = 2 * math.pi;
    final sectionAngleWithSpace = (totalAngle - (totalSections * spaceBetweenItems)) / totalSections;
    const spaceOnBothSides = spaceBetweenItems;

    for (var i = 0; i < items.length; i++) {
      final startAngle = i * (sectionAngleWithSpace + spaceBetweenItems) + spaceOnBothSides;

      paint.color = items[i].color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngleWithSpace,
        true,
        paint,
      );
    }

    // Draw a circle at the center of the wheel
    final centerCircleRadius = radius * 0.05; // Adjust the radius of the center circle as needed
    final centerCirclePaint = Paint()..color = Colors.white; // Adjust the color of the center circle as needed
    canvas.drawCircle(center, centerCircleRadius, centerCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
