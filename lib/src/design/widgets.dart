import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TCentury extends StatelessWidget {
  final String data;
  const TCentury(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Text(
      data,
      textAlign: TextAlign.center,
      // ignore: prefer_const_constructors
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'Century'),
    );
  }
}
