import 'dart:math';
import 'package:flutter/material.dart';

enum CircularTextDirection { clockwise, anticlockwise }

enum CircularTextPosition { outside, inside }

class CircularText extends StatelessWidget {
  //Text
  final String text;

  //Text style
  final TextStyle textStyle;

  //Circle radius
  final double radius;

  //Spacing between characters
  final double spacing;

  //Text starting position
  final double startAngle;

  //Background shape paint
  final Paint backgroundPaint;

  //Text position either outside or inside circle
  final CircularTextPosition position;

  //Text direction either clockwise or anticlockwise
  final CircularTextDirection direction;

  CircularText(
      {Key key,
      @required this.text,
      this.textStyle = const TextStyle(),
      this.radius = 125,
      this.spacing = 10,
      this.startAngle = 0,
      Paint backgroundPaint,
      this.position = CircularTextPosition.inside,
      this.direction = CircularTextDirection.clockwise})
      : assert(text != null),
        assert(textStyle != null),
        assert(radius != null && radius >= 0),
        assert(spacing != null && spacing >= 0),
        assert(startAngle != null && startAngle >= 0),
        this.backgroundPaint = backgroundPaint ??
            (backgroundPaint = Paint()..color = Colors.transparent),
        assert(position != null),
        assert(direction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox.fromSize(
        size: Size(2 * radius, 2 * radius),
        child: CustomPaint(
          painter: CircularTextPainter(
              text: text,
              textStyle: textStyle,
              spacing: spacing,
              startAngle: startAngle,
              backgroundPaint: backgroundPaint,
              position: position,
              direction: direction),
        ),
      ),
    );
  }
}

class CircularTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final double spacing;
  final double startAngle;
  final Paint backgroundPaint;
  final CircularTextPosition position;
  final CircularTextDirection direction;

  double _radius = 0.0;
  List<TextPainter> _charPainters = [];

  CircularTextPainter(
      {this.text,
      this.textStyle,
      this.spacing,
      this.startAngle,
      this.backgroundPaint,
      this.position,
      this.direction}) {
    for (final char in text.toUpperCase().split("")) {
      final tp = TextPainter(
          text: TextSpan(text: char, style: textStyle),
          textDirection: TextDirection.ltr);
      tp.layout();
      _charPainters.add(tp);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _radius = min(size.width / 2, size.height / 2);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, _radius, backgroundPaint);

    if (direction == CircularTextDirection.clockwise) {
      _paintTextClockwise(canvas, size);
    } else {
      _paintTextAntiClockwise(canvas, size);
    }
  }

  void _paintTextClockwise(Canvas canvas, Size size) {
    bool hasStrokeStyle = backgroundPaint.style == PaintingStyle.stroke &&
        backgroundPaint.strokeWidth > 0.0;

    canvas.rotate((startAngle - 90) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? (-_radius - tp.height) -
              (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : -_radius - (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(spacing * pi / 180);
    }
  }

  void _paintTextAntiClockwise(Canvas canvas, Size size) {
    bool hasStrokeStyle = backgroundPaint.style == PaintingStyle.stroke &&
        backgroundPaint.strokeWidth > 0.0;

    canvas.rotate((-startAngle - 270) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? _radius + (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : (_radius - tp.height) + (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(-spacing * pi / 180);
    }
  }

  @override
  bool shouldRepaint(CircularTextPainter oldDelegate) =>
      oldDelegate.text != text ||
      oldDelegate.textStyle != textStyle ||
      oldDelegate.spacing != spacing ||
      oldDelegate.startAngle != startAngle ||
      oldDelegate.backgroundPaint != backgroundPaint ||
      oldDelegate.position != position ||
      oldDelegate.direction != direction;
}
