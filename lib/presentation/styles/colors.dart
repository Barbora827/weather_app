import 'package:flutter/material.dart';

abstract class WColors {
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  static const Color lightBlue = Color.fromARGB(255, 153, 221, 255);
  static const Color red = Color.fromARGB(255, 255, 78, 86);
  static const Color yellow = Color.fromARGB(255, 255, 240, 124);
  static const Color purple = Color.fromARGB(255, 103, 37, 169);
  static const Color blue = Color.fromARGB(255, 61, 149, 232);

  static const List<Color> dayGradient = [
    Color.fromARGB(255, 100, 155, 244),
    Color.fromARGB(255, 83, 206, 255),
    Color.fromARGB(255, 255, 110, 134)
  ];

  static const List<Color> nightGradient = [
    Color.fromARGB(255, 16, 27, 129),
    Color.fromARGB(255, 103, 37, 169),
    Color.fromARGB(255, 207, 88, 195)
  ];

  static List<Color> getTimeBasedGradient(int hour) {
    if (hour >= 8 && hour <= 19) {
      return WColors.dayGradient;
    } else {
      return WColors.nightGradient;
    }
  }

  static Color getTimeBasedColor(int hour) {
    if (hour >= 8 && hour <= 19) {
      return WColors.blue;
    } else {
      return WColors.purple;
    }
  }
}
