import 'package:flutter/material.dart';

class GoogleIcon extends StatelessWidget {
  final double size;

  const GoogleIcon({super.key, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  static const Color _blue = Color(0xFF4285F4);
  static const Color _green = Color(0xFF34A853);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    canvas.save();
    canvas.scale(size.width / 18);

    _drawBlue(canvas);
    _drawGreen(canvas);
    _drawYellow(canvas);
    _drawRed(canvas);

    canvas.restore();
  }

  void _drawBlue(Canvas canvas) {
    final path = Path()
      ..moveTo(17.64, 9.2045)
      ..cubicTo(17.64, 8.5664, 17.5827, 7.9527, 17.4764, 7.3636)
      ..lineTo(9, 7.3636)
      ..relativeLineTo(0, 3.4814)
      ..relativeLineTo(4.8436, 0)
      ..cubicTo(13.635, 11.97, 13.0009, 12.9232, 12.0477, 13.5614)
      ..relativeLineTo(0, 2.2581)
      ..relativeLineTo(2.9087, 0)
      ..cubicTo(16.6582, 14.2527, 17.64, 11.9455, 17.64, 9.2045)
      ..close();

    canvas.drawPath(path, Paint()..color = _blue);
  }

  void _drawGreen(Canvas canvas) {
    final path = Path()
      ..moveTo(9, 18)
      ..cubicTo(11.43, 18, 13.4673, 17.194, 14.9564, 15.8195)
      ..relativeLineTo(-2.9087, -2.2581)
      ..cubicTo(11.2418, 14.1014, 10.2109, 14.4204, 9, 14.4204)
      ..cubicTo(6.656, 14.4204, 4.6718, 12.8373, 3.964, 10.71)
      ..lineTo(0.9574, 10.71)
      ..relativeLineTo(0, 2.3318)
      ..cubicTo(2.4382, 15.9832, 5.4818, 18, 9, 18)
      ..close();

    canvas.drawPath(path, Paint()..color = _green);
  }

  void _drawYellow(Canvas canvas) {
    final path = Path()
      ..moveTo(3.964, 10.71)
      ..cubicTo(3.784, 10.17, 3.6818, 9.5932, 3.6818, 9)
      ..cubicTo(3.6818, 8.4068, 3.7841, 7.83, 3.9641, 7.29)
      ..lineTo(3.9641, 4.9582)
      ..lineTo(0.9573, 4.9582)
      ..arcToPoint(
        const Offset(0, 9),
        radius: const Radius.circular(8.9965),
        clockwise: false,
      )
      ..cubicTo(0, 10.4523, 0.3477, 11.8268, 0.9573, 13.0418)
      ..lineTo(3.964, 10.71)
      ..close();

    canvas.drawPath(path, Paint()..color = _yellow);
  }

  void _drawRed(Canvas canvas) {
    final path = Path()
      ..moveTo(9, 3.5795)
      ..cubicTo(10.3214, 3.5795, 11.5077, 4.0336, 12.4405, 4.9255)
      ..relativeLineTo(2.5813, -2.5814)
      ..cubicTo(13.4632, 0.8918, 11.426, 0, 9, 0)
      ..cubicTo(5.4818, 0, 2.4382, 2.0168, 0.9573, 4.9582)
      ..lineTo(3.964, 7.29)
      ..cubicTo(4.6718, 5.1627, 6.656, 3.5795, 9, 3.5795)
      ..close();

    canvas.drawPath(path, Paint()..color = _red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
