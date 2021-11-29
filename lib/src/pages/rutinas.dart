import 'package:another_flushbar/flushbar.dart';
import 'package:app/src/design/components/text_century.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/design/widgets/button.dart';
import 'package:app/src/design/widgets/input.dart';
import 'package:flutter/material.dart';

class RutinasPage extends StatefulWidget {
  const RutinasPage({Key? key}) : super(key: key);

  @override
  _RutinasPageState createState() => _RutinasPageState();
}

class _RutinasPageState extends State<RutinasPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController typeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Center(
          child: TCentury(
        'PAGE 2',
        fontColor: Colored.primary,
      )),
    );
  }
}
