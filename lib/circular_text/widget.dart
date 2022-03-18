import 'dart:math';

import 'package:flutter/material.dart';

import 'model.dart';

class CircularText extends StatelessWidget {
  ///List of text
  final List<TextItem> children;

  /// Circle radius
  final double radius;

  /// Text position either outside or inside circle
  final CircularTextPosition position;

  /// Background paint
  final Paint? backgroundPaint;

  CircularText({
    Key? key,
    required this.children,
    this.radius = 125,
    this.position = CircularTextPosition.inside,
    this.backgroundPaint,
  })  : assert(radius >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox.fromSize(
        size: Size(2 * radius, 2 * radius),
        child: CustomPaint(
          painter: _CircularTextPainter(
            children: children,
            position: position,
            backgroundPaint: backgroundPaint,
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final List<TextItem> children;
  final CircularTextPosition position;
  final Paint backgroundPaint;
  final TextDirection textDirection;

  double _radius = 0.0;

  _CircularTextPainter({
    required this.children,
    this.position = CircularTextPosition.inside,
    Paint? backgroundPaint,
    required this.textDirection,
  }) : this.backgroundPaint =
            backgroundPaint ?? (Paint()..color = Colors.transparent);

  @override
  void paint(Canvas canvas, Size size) {
    _radius = min(size.width / 2, size.height / 2);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, _radius, backgroundPaint);

    for (final textItem in children) {
      canvas.save();
      List<TextPainter> _charPainters = [];
      Text text = textItem.text;
      for (final char in text.data!.split("")) {
        _charPainters.add(TextPainter(
            text: TextSpan(text: char, style: text.style),
            textDirection: textDirection)
          ..layout());
      }
      if (textItem.direction == CircularTextDirection.clockwise) {
        _paintTextClockwise(canvas, size, textItem, _charPainters);
      } else {
        _paintTextAntiClockwise(canvas, size, textItem, _charPainters);
      }
      canvas.restore();
    }
  }

  void _paintTextClockwise(Canvas canvas, Size size, TextItem textItem,
      List<TextPainter> _charPainters) {
    bool hasStrokeStyle = backgroundPaint.style == PaintingStyle.stroke &&
        backgroundPaint.strokeWidth > 0.0;

    double angleShift = _calculateAngleShift(textItem, _charPainters.length);
    canvas.rotate((textItem.startAngle + 90 - angleShift) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? (-_radius - tp.height) -
              (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : -_radius - (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(textItem.space * pi / 180);
    }
  }

  void _paintTextAntiClockwise(Canvas canvas, Size size, TextItem textItem,
      List<TextPainter> _charPainters) {
    bool hasStrokeStyle = backgroundPaint.style == PaintingStyle.stroke &&
        backgroundPaint.strokeWidth > 0.0;

    double angleShift = _calculateAngleShift(textItem, _charPainters.length);
    canvas.rotate((textItem.startAngle - 90 + angleShift) * pi / 180);
    for (int i = 0; i < _charPainters.length; i++) {
      final tp = _charPainters[i];
      final x = -tp.width / 2;
      final y = position == CircularTextPosition.outside
          ? _radius + (hasStrokeStyle ? backgroundPaint.strokeWidth / 2 : 0.0)
          : (_radius - tp.height) + (hasStrokeStyle ? tp.height / 2 : 0.0);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(-textItem.space * pi / 180);
    }
  }

  double _calculateAngleShift(TextItem textItem, int textLength) {
    double angleShift = -1;
    switch (textItem.startAngleAlignment) {
      case StartAngleAlignment.start:
        angleShift = 0;
        break;
      case StartAngleAlignment.center:
        int halfItemsLength = textLength ~/ 2;
        if (textLength % 2 == 0) {
          angleShift =
              ((halfItemsLength - 1) * textItem.space) + (textItem.space / 2);
        } else {
          angleShift = (halfItemsLength * textItem.space);
        }
        break;
      case StartAngleAlignment.end:
        angleShift = (textLength - 1) * textItem.space;
        break;
    }
    return angleShift;
  }

  @override
  bool shouldRepaint(_CircularTextPainter oldDelegate) {
    bool isTextItemsChanged() {
      bool isChanged = false;
      for (int i = 0; i < children.length; i++) {
        if (i >= oldDelegate.children.length || children[i].isChanged(oldDelegate.children[i])) {
          isChanged = true;
          break;
        }
      }
      return isChanged;
    }

    bool isBackgroundPaintChanged() {
      return oldDelegate.backgroundPaint.color != backgroundPaint.color ||
          oldDelegate.backgroundPaint.style != backgroundPaint.style ||
          oldDelegate.backgroundPaint.strokeWidth !=
              backgroundPaint.strokeWidth;
    }

    return isTextItemsChanged() ||
        oldDelegate.position != position ||
        oldDelegate.textDirection != textDirection ||
        isBackgroundPaintChanged();
  }
}
