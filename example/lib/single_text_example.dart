import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';

class SingleTextDemo extends StatefulWidget {
  @override
  _SingleTextDemoState createState() => _SingleTextDemoState();
}

class _SingleTextDemoState extends State<SingleTextDemo> {
  double _space = 10;
  double _startAngle = 0;
  double _strokeWidth = 0.0;
  bool _showStroke = false;
  bool _showBackground = true;
  StartAngleAlignment _startAngleAlignment = StartAngleAlignment.start;
  CircularTextPosition _position = CircularTextPosition.inside;
  CircularTextDirection _direction = CircularTextDirection.clockwise;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
        child: SizedBox.fromSize(
          size: Size(360, double.infinity),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildCircularTextWidget(),
              SizedBox.fromSize(size: Size(40, 40)),
              Expanded(
                flex: 1,
                child: CustomScrollView(
                  slivers: <Widget>[
                    buildSpacePanel(),
                    buildStartAnglePanel(),
                    buildCircularTextAnglePositionPanel(),
                    buildStrokeWidthPanel(),
                    buildShowBackgroundShapePanel(),
                    buildCircularTextPositionPanel(),
                    buildCircularTextDirectionPanel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircularTextWidget() {
    final backgroundPaint = Paint();
    if (_showBackground) {
      backgroundPaint..color = Colors.grey.shade200;
      if (_showStroke) {
        backgroundPaint
          ..color = Colors.grey.shade200
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokeWidth;
      }
    } else {
      backgroundPaint.color = Colors.transparent;
    }

    return CircularText(
      children: [
        TextItem(
          text: Text(
            "circular text".toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          space: _space,
          startAngle: _startAngle,
          startAngleAlignment: _startAngleAlignment,
          direction: _direction,
        ),
      ],
      radius: 125,
      position: _position,
      backgroundPaint: backgroundPaint,
    );
  }

  Widget buildSpacePanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("SPACE", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _space,
            min: 0,
            max: 30,
            onChanged: (value) {
              setState(() => _space = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildStartAnglePanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("START ANGLE", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _startAngle,
            min: 0,
            max: 360,
            divisions: 4,
            label: "${_startAngle.toInt()}",
            onChanged: (value) {
              setState(() => _startAngle = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildCircularTextAnglePositionPanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("START ANGLE ALIGNMENT",
              style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<StartAngleAlignment>(
            value: _startAngleAlignment,
            items: [
              DropdownMenuItem(
                child: Text("START"),
                value: StartAngleAlignment.start,
              ),
              DropdownMenuItem(
                child: Text("CENTER"),
                value: StartAngleAlignment.center,
              ),
              DropdownMenuItem(
                child: Text("END"),
                value: StartAngleAlignment.end,
              ),
            ],
            onChanged: (dynamic value) {
              setState(() => _startAngleAlignment = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildStrokeWidthPanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("STROKE WIDTH", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _strokeWidth,
            min: 0,
            max: 100,
            onChanged: _showStroke
                ? (value) {
                    setState(() => _strokeWidth = value);
                  }
                : null,
          ),
          Checkbox(
            value: _showStroke,
            onChanged: (dynamic value) {
              setState(() => _showStroke = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildShowBackgroundShapePanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("SHOW BACKGROUND",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: _showBackground,
            onChanged: (dynamic value) {
              setState(() => _showBackground = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildCircularTextPositionPanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("POSITION", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<CircularTextPosition>(
            value: _position,
            items: [
              DropdownMenuItem(
                child: Text("INSIDE"),
                value: CircularTextPosition.inside,
              ),
              DropdownMenuItem(
                child: Text("OUTSIDE"),
                value: CircularTextPosition.outside,
              )
            ],
            onChanged: (dynamic value) {
              setState(() => _position = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildCircularTextDirectionPanel() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("DIRECTION", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<CircularTextDirection>(
            value: _direction,
            items: [
              DropdownMenuItem(
                child: Text("CLOCKWISE"),
                value: CircularTextDirection.clockwise,
              ),
              DropdownMenuItem(
                child: Text("ANTI CLOCKWISE"),
                value: CircularTextDirection.anticlockwise,
              )
            ],
            onChanged: (dynamic value) {
              setState(() => _direction = value);
            },
          )
        ],
      ),
    );
  }
}
