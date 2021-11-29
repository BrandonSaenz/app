import 'package:flutter/material.dart';

class TCentury extends StatelessWidget {
  final String data;
  final TextAlign? aling;
  final Color? fontColor;
  const TCentury(this.data, {Key? key, this.aling, this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: aling != null ? aling : TextAlign.center,
      style: TextStyle(
          color: fontColor != null ? fontColor : Colors.white,
          fontSize: 20,
          fontFamily: 'Century'),
    );
  }
}
