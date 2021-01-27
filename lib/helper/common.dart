import 'package:flutter/material.dart';

class Common {
  static Color completeColor = Colors.lightBlue[700];
  static Color inProgressColor = Colors.lightBlue;
  static Color todoColor = Color(0xff5e6172);

  static Color getColor(int index, int _processIndex) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }
}
