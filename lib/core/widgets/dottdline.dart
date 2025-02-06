import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double width;
  final double spacing;
  final Color color;

  const DottedLine({
    super.key,
    required this.width,
    required this.spacing,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 1), // Height is 1 for the line
      painter: DottedLinePainter(width: width, spacing: spacing, color: color),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double width;
  final double spacing;
  final Color color;

  DottedLinePainter({
    required this.width,
    required this.spacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    double length = 0;
    while (length < size.width) {
      canvas.drawLine(Offset(length, 0), Offset(length + spacing, 0), paint);
      length += spacing * 2; // Increment by twice the spacing to create gaps
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
