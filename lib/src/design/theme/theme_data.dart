import 'dart:ui';
import 'package:flutter/material.dart';

class Colored {
  static const Color primary = Color.fromRGBO(0, 0, 0, 1);
  static const Color dark = Color.fromRGBO(25, 25, 25, 1);
  static const Color background = primary;
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
