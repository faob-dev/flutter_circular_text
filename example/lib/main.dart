import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_text/circular_text.dart';

void main() {
  runApp(MaterialApp(home: CircularTextDemo()));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class CircularTextDemo extends StatefulWidget {
  @override
  _CircularTextDemoState createState() => _CircularTextDemoState();
}

class _CircularTextDemoState extends State<CircularTextDemo> {
  double _spacing = 10;
  double _startAngle = 0;
  bool _showBackground = true;
  BackgroundShape _backgroundShape = BackgroundShape.circle;
  CircularTextPosition _position = CircularTextPosition.inside;
  CircularTextDirection _direction = CircularTextDirection.clockwise;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
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
                    buildSpacingSlider(),
                    buildSStartAngleSlider(),
                    buildShowBackgroundShapeCheckBox(),
                    buildBackgroundShapeChoiceBox(),
                    buildCircularTextPositionChoiceBox(),
                    buildCircularTextDirectionChoiceBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircularTextWidget(){
    return CircularText(
      text: "circular text widget",
      textStyle: TextStyle(
          fontSize: 25,
          color: Colors.blue,
          fontWeight: FontWeight.bold
      ),
      radius: 125,
      spacing: _spacing,
      startAngle: _startAngle,
      backgroundPaint: Paint()
        ..color = _showBackground
            ? Colors.grey.shade200
            : Colors.transparent,
      backgroundShape: _backgroundShape,
      position: _position,
      direction: _direction,
    );
  }

  Widget buildSpacingSlider(){
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("SPACING", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _spacing,
            min: 0,
            max: 30,
            onChanged: (value) {
              setState(() => _spacing = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildSStartAngleSlider(){
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("START ANGLE", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _startAngle,
            min: 0,
            max: 360,
            onChanged: (value) {
              setState(() => _startAngle = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildBackgroundShapeChoiceBox(){
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("BACKGROUND SHAPE", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<BackgroundShape>(
            value: _backgroundShape,
            items: [
              DropdownMenuItem(
                child: Text("CIRCLE"),
                value: BackgroundShape.circle,
              ),
              DropdownMenuItem(
                child: Text("RECTANGLE"),
                value: BackgroundShape.rectangle,
              )
            ],
            onChanged: (value) {
              setState(() => _backgroundShape = value);
            },
          )

        ],
      ),
    );
  }

  Widget buildCircularTextPositionChoiceBox(){
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
            onChanged: (value) {
              setState(() => _position = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildCircularTextDirectionChoiceBox(){
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
            onChanged: (value) {
              setState(() => _direction = value);
            },
          )
        ],
      ),
    );
  }

  Widget buildShowBackgroundShapeCheckBox(){
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("SHOW BACKGROUND", style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: _showBackground,
            onChanged: (value) {
              setState(() => _showBackground = value);
            },
          )
        ],
      ),
    );
  }
}