# Circular Text Widget

[![pub package](https://img.shields.io/pub/v/flutter_circular_text.svg)](https://pub.dartlang.org/packages/flutter_circular_text)

## Installation

Add dependency in `pubspec.yaml`:
```yaml
dependencies:
  flutter_circular_text: "^0.3.1"
```

Import in your project:
```dart
import 'package:flutter_circular_text/circular_text.dart';
```

## Basic usage

```dart
CircularText(
  children: [
    TextItem(
      text: Text(
        "Chuck Norris".toUpperCase(),
        style: TextStyle(
          fontSize: 28,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      space: 12,
      startAngle: -90,
      startAngleAlignment: StartAngleAlignment.center,
      direction: CircularTextDirection.clockwise,
    ),
    TextItem(
      text: Text(
        "top 100 Facts".toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          color: Colors.amberAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      space: 10,
      startAngle: 90,
      startAngleAlignment: StartAngleAlignment.center,
      direction: CircularTextDirection.anticlockwise,
    ),
  ],
  radius: 125,
  position: CircularTextPosition.inside,
  backgroundPaint: Paint()..color = Colors.grey.shade200,
)
```

## Examples

[example](https://github.com/faob-dev/flutter_circular_text/tree/master/example) project contains single and multi text demos

### Demos

##### Single Text Demo
![alt tag](https://raw.githubusercontent.com/faob-dev/flutter_circular_text/master/screenshots/single_circular_text.gif)

##### Multi Text Demo
<img src="https://raw.githubusercontent.com/faob-dev/flutter_circular_text/master/screenshots/multi_circular_text.jpeg" width=270>

## Changelog
Check [Changelog](https://github.com/faob-dev/flutter_circular_text/blob/master/CHANGELOG.md) for updates

## Bugs/Requests
Reporting issues and requests for new features are always welcome.
