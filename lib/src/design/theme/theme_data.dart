import 'dart:ui';
import 'package:flutter/material.dart';

class Colored {
  static const Color primary = gold;
  static const Color background = dark;
  static const Color gold = Color.fromRGBO(165, 132, 48, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color dark = Color.fromRGBO(25, 25, 25, 1);
}

class Window {
  BuildContext context;
  Window(this.context);

  w(double numPorcent) {
    Size media = MediaQuery.of(context).size;
    return media.width * (numPorcent / 100);
  }

  h(double numPorcent) {
    Size media = MediaQuery.of(context).size;
    return media.height * (numPorcent / 100);
  }
}
