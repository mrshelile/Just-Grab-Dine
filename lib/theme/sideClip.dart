import 'package:justgrab_dine/theme/colors.dart';
import 'package:flutter/material.dart';

class TopRightClip1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    // paint.color = Colors.blueAccent;
    var rect = Offset.zero & size;
    paint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [brown1, gold1]).createShader(rect);

    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.3, size.width, size.height * 0.3);
    // path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    //     path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.moveTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class TopRightClip2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    // paint.color = Colors.blueAccent;
    var rect = Offset.zero & size;
    paint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [brown1, gold1]).createShader(rect);

    path.moveTo(size.width * 0.52, 0);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 0.3, size.width, size.height * 0.28);
    // path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    //     path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.moveTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
