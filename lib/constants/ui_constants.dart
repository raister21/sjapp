import 'package:flutter/material.dart';

class UiConstants {
  final double defaultPads = 16.0;
  final double defaultSmallPads = 8.0;
  final double roundedRadius = 20.0;
  final double roundedSmallRadius = 5.0;
  final Color primaryDarkGradient = Color.fromARGB(255, 232, 112, 104);
  final double circleIndicatorSmall = 76;
  final double circleIndicatorBig = 140;

  Map<int, Color> myColor = {
    50: Color.fromRGBO(232, 112, 104, .1),
    100: Color.fromRGBO(232, 112, 104, .2),
    200: Color.fromRGBO(232, 112, 104, .3),
    300: Color.fromRGBO(232, 112, 104, .4),
    400: Color.fromRGBO(232, 112, 104, .5),
    500: Color.fromRGBO(232, 112, 104, .6),
    600: Color.fromRGBO(232, 112, 104, .7),
    700: Color.fromRGBO(232, 112, 104, .8),
    800: Color.fromRGBO(232, 112, 104, .9),
    900: Color.fromRGBO(232, 112, 104, 1),
  };
}
