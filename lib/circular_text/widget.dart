import 'dart:math';
import 'package:flutter/material.dart';

enum CircularTextDirection { clockwise, anticlockwise }

enum CircularTextPosition { outside, inside }

class CircularText extends StatelessWidget {
  //Text
  final Text text;

  //Circle radius
  final double radius;

  //Spacing between characters
  final double space;

  //Text starting position
  final double startAngle;

  //Text position either outside or inside circle
  final CircularTextPosition position;

  //Text direction either clockwise or anticlockwise
  final CircularTextDirection direction;

  //Background shape paint
  final Paint backgroundPaint;

  CircularText(
      {Key key,
      @required this.text,
      this.radius = 125,
      this.space = 10,
      this.startAngle = 0,
      Paint backgroundPaint,
      this.position = CircularTextPosition.inside,
      this.direction = CircularTextDirection.clockwise})
      : assert(text != null),
        assert(radius != null && radius >= 0),
        assert(space != null && space >= 0),
        assert(startAngle != null),
        assert(position != null),
        assert(direction != null),
        this.backgroundPaint = backgroundPaint ??
            (backgroundPaint = Paint()..color = Colors.transparent),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox.fromSize(
        size: Size(2 * radius, 2 * radius),
        child: CustomPaint(
          painter: _CircularTextPainter(
            text: text,
            space: space,
            startAngle: startAngle,
            position: position,
            direction: direction,
            backgroundPaint: backgroundPaint,
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final Text text;
  final double space;
  final double startAngle;
  final CircularTextPosition position;
  final CircularTextDirection direction;
  final Paint backgroundPaint;

  double _radius = 0.0;
  List<TextPainter> _charPainters = [];

  _CircularTextPainter(
      {this.text,
      this.space,
      this.startAngle,
      this.position,
      this.direction,
      this.backgroundPaint,
      TextDirection textDirection}) {
    for (final char in text.data.toUpperCase().split("")) {
      _charPainters.add(TextPainter(
          text: TextSpan(text: char, style: text.style),
          textDirection: textDirection)
        ..layout());
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

    canvas.rotate((startAngle + 90) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? (-_radius - tp.height) -
              (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : -_radius - (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(space * pi / 180);
    }
  }

  void _paintTextAntiClockwise(Canvas canvas, Size size) {
    bool hasStrokeStyle = backgroundPaint.style == PaintingStyle.stroke &&
        backgroundPaint.strokeWidth > 0.0;

    canvas.rotate((startAngle - 90) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? _radius + (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : (_radius - tp.height) + (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(-space * pi / 180);
    }
  }

  @override
  bool shouldRepaint(_CircularTextPainter oldDelegate) =>
      oldDelegate.text != text ||
      oldDelegate.space != space ||
      oldDelegate.startAngle != startAngle ||
      oldDelegate.position != position ||
      oldDelegate.direction != direction ||
      oldDelegate.backgroundPaint != backgroundPaint;
}
