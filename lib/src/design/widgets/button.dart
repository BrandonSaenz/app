import 'package:app/src/design/components/text_century.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  const Button(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colored.dark, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(15),
      child: TCentury(text != null ? text : 'BUTTON'),
    );
  }
}
