import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff353542);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.96, size.width,
        size.height * 0.96);
    path.cubicTo(size.width, size.height * 0.96, size.width, size.height * 0.96,
        size.width, size.height * 0.96);
    path.cubicTo(size.width * 0.98, size.height * 0.96, size.width * 0.96,
        size.height * 0.98, size.width * 0.96, size.height);
    path.cubicTo(size.width * 0.96, size.height, size.width * 0.96, size.height,
        size.width * 0.96, size.height);
    path.cubicTo(size.width * 0.96, size.height, size.width * 0.04, size.height,
        size.width * 0.04, size.height);
    path.cubicTo(size.width * 0.04, size.height, size.width * 0.04, size.height,
        size.width * 0.04, size.height);
    path.cubicTo(size.width * 0.04, size.height * 0.98, size.width * 0.02,
        size.height * 0.96, 0, size.height * 0.96);
    path.cubicTo(0, size.height * 0.96, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, 0, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
