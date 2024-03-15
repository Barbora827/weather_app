import 'package:flutter/material.dart';

abstract class WColors {
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  static const Color lightBlue = Color.fromARGB(255, 121, 159, 202);
  static const Color coldBlue = Color.fromARGB(255, 129, 203, 248);
  static const Color lightPurple = Color.fromARGB(255, 101, 93, 150);
  static const Color darkPurple = Color.fromARGB(255, 67, 63, 93);
  static const Color red = Color.fromARGB(255, 255, 78, 86);
  static const Color yellow = Color.fromARGB(255, 255, 240, 124);
  static const Color purple = Color.fromARGB(255, 103, 37, 169);
  static const Color blue = Color.fromARGB(255, 65, 91, 127);
  static const Color green = Color.fromARGB(255, 117, 206, 62);

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
      return const Color.fromARGB(255, 57, 137, 198);
    } else {
      return WColors.purple;
    }
  }
}
