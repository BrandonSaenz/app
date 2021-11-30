import 'package:app/src/design/theme/theme_data.dart';
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

class ConnectionWaiting extends StatelessWidget {
  const ConnectionWaiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Window(context).w(20),
            height: Window(context).w(20),
            margin: EdgeInsets.all(30),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colored.primary,
              strokeWidth: 10,
            ),
          ),
          TCentury('CARGANDO USUARIOS...', fontColor: Colored.primary)
        ],
      ),
    );
  }
}

class ConnectionNone extends StatelessWidget {
  const ConnectionNone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TCentury('SIN DATOS', fontColor: Colored.primary)],
      ),
    );
  }
}

class ConnectionDone extends StatelessWidget {
  const ConnectionDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TCentury('CONEXION TERMINADA', fontColor: Colored.primary)],
      ),
    );
  }
}
