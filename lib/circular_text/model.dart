import 'package:flutter/material.dart';

enum CircularTextDirection { clockwise, anticlockwise }

enum CircularTextPosition { outside, inside }

enum StartAngleAlignment { start, center, end }

class TextItem {
  /// Text
  final Text text;

  /// Space between characters
  final double space;

  /// Text starting position
  final double startAngle;

  /// Text alignment around [startAngle]
  /// [StartAngleAlignment.start] text will starts from [startAngle]
  /// [StartAngleAlignment.center] text will be centered on [startAngle]
  /// [StartAngleAlignment.end] text will ends on [startAngle]
  final StartAngleAlignment startAngleAlignment;

  /// Text direction either clockwise or anticlockwise
  final CircularTextDirection direction;

  TextItem({
    required this.text,
    this.space = 10,
    this.startAngle = 0,
    this.startAngleAlignment = StartAngleAlignment.start,
    this.direction = CircularTextDirection.clockwise,
  }) : assert(space >= 0);

  bool isChanged(TextItem oldTextItem) {
    bool isTextChanged() {
      return oldTextItem.text.data != text.data ||
          oldTextItem.text.style != text.style;
    }

    return isTextChanged() ||
        oldTextItem.space != space ||
        oldTextItem.startAngle != startAngle ||
        oldTextItem.startAngleAlignment != startAngleAlignment ||
        oldTextItem.direction != direction;
  }
}
