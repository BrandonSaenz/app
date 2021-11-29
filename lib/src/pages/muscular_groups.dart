import 'dart:async';
import 'package:app/src/design/components/text_century.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:app/src/design/widgets/input.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:app/src/design/widgets/button.dart';
import 'package:flutter/material.dart';

class MuscularPage extends StatefulWidget {
  const MuscularPage({Key? key}) : super(key: key);

  @override
  _MuscularPageState createState() => _MuscularPageState();
}

class _MuscularPageState extends State<MuscularPage> {
  String API_create = "http://fenrir.com.mx/muscular_groups/post.php?";
  // String API_update = "http://fenrir.com.mx/users/update.php?";
  // String API_delete = "http://fenrir.com.mx/users/delete.php?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => onCreate(context), child: Button('AGREGAR'))
            ],
          )
        ],
      ),
    );
  }

  Future apiCreate(String name, String type) async {
    var url = '${API_create}name=${name}&type=${type}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se creo el registro con exito',
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'ERROR',
        message: '',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  void onCreate(BuildContext context) async {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController typeCtrl = TextEditingController();

    showModalBottomSheet(
        useRootNavigator: false,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(30),
            height: Window(context).w(150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: TCentury(
                    'Crear registro',
                    fontColor: Colored.primary,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Field(
                        nameCtrl,
                        hint: 'Ingresar nombre',
                        label: 'Nombre',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  apiCreate(nameCtrl.text, typeCtrl.text),
                              child: Button('CREAR')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Button('CANCELAR'))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
