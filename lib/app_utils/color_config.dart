import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color toHexColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse('0x$hexColor'));
  }
}
