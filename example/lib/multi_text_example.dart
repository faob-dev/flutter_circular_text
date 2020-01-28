import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';

class MultiTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF303030),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildBackground(),
            _buildCircularTextWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularTextWidget() {
    return CircularText(
      children: [
        TextItem(
          text: Text(
            "Chuck Norris".toUpperCase(),
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
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
        TextItem(
          text: Text(
            "༒".toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          space: 10,
          startAngle: 180,
          startAngleAlignment: StartAngleAlignment.center,
          direction: CircularTextDirection.clockwise,
        ),
        TextItem(
          text: Text(
            "༒".toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          space: 10,
          startAngle: 0,
          startAngleAlignment: StartAngleAlignment.center,
          direction: CircularTextDirection.clockwise,
        ),
      ],
      radius: 135,
      position: CircularTextPosition.inside,
    );
  }

  Widget _buildBackground() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Color(0xFF101010),
        ),
        BoxShadow(
          color: Color(0xFF303030),
          blurRadius: 10,
        ),
      ]),
    );
  }
}
