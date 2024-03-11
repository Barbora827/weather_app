import 'package:flutter/material.dart';

abstract class WColors {
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  static const Color cold = Color.fromARGB(255, 153, 221, 255);
  static const Color hot = Color.fromARGB(255, 255, 78, 86);
  static const Color sun = Color.fromARGB(255, 255, 240, 124);
  static const Color moon = Color.fromARGB(255, 90, 93, 255);

  static const List<Color> dayGradient = [
    Color.fromARGB(255, 100, 157, 244),
    Color.fromARGB(255, 119, 212, 248),
    Color.fromARGB(255, 178, 115, 72)
  ];

  static const List<Color> nightGradient = [
    Color.fromARGB(255, 16, 27, 129),
    Color.fromARGB(255, 103, 37, 169),
    Color.fromARGB(255, 207, 88, 195)
  ];
}
