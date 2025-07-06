import 'package:flutter/material.dart';

class EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Create the path for the house shape
    Path path = Path();

    // Define the roof height (about 1/3 of total height)
    double roofHeight = size.height * 0.35;

    // Start from bottom left corner
    path.moveTo(0, size.height);

    // Go up to where the roof starts (left side of rectangle base)
    path.lineTo(0, roofHeight);

    // Go up and inward to the peak of the triangle roof
    path.lineTo(size.width / 2, 0);

    // Go down and outward to the right side of the roof
    path.lineTo(size.width, roofHeight);

    // Go down to bottom right corner
    path.lineTo(size.width, size.height);

    // Close the path back to bottom left
    path.close();

    // Fill the shape with white
    canvas.drawPath(path, fillPaint);

    // Draw the black outline
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Create the path for the custom shape
    Path path = Path();

    // Start from bottom left
    path.moveTo(0, size.height);

    // Go to top left
    path.lineTo(0, 0);

    // Create the angled notch - going down and right
    path.lineTo(size.width * 0.5, size.height * 0.7);

    // Go back up to the right side of the notch
    path.lineTo(size.width, 0);

    // Go to bottom right
    path.lineTo(size.width, size.height);

    // Close the path back to bottom left
    path.close();

    // Fill the shape with white
    canvas.drawPath(path, fillPaint);

    // Draw the black outline
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
