import 'package:example/single_text_example.dart';
import 'package:example/multi_text_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: SingleTextDemo()));
//  runApp(MaterialApp(home: MultiTextDemo()));
  SystemChrome.setEnabledSystemUIOverlays([]);
}