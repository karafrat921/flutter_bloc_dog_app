
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double xOffset = size.width * 0.0368;
    final double yOffset = size.height * 0.1369;

    Path path = Path()
      ..moveTo(xOffset, yOffset)
      ..cubicTo(
          size.width * 0.0402, size.height * 0.0580,
          size.width * 0.0580, 0, size.width * 0.0789, 0)
      ..lineTo(size.width * 0.9211, 0)
      ..cubicTo(
          size.width * 0.9420, 0,
          size.width * 0.9598, size.height * 0.0580,
          size.width * 0.9632, size.height * 0.1369)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(xOffset, yOffset)
      ..close();

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF2F2F7).withOpacity(1.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}