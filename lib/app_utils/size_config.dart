import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static Orientation screenOrientation;
  static double textScaleFactor;
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    screenOrientation = MediaQuery.of(context).orientation;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;
  }
}
