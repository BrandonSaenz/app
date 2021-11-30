import 'dart:async';
import 'package:app/src/API/controllers.dart';
import 'package:app/src/API/models.dart';
import 'package:app/src/design/widgets/input.dart';
import 'package:app/src/design/widgets/components.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final dataStream = StreamController<List<ModelUsers>>();

  String API_create = "http://fenrir.com.mx/users/post.php?";
  String API_update = "http://fenrir.com.mx/users/update.php?";
  String API_delete = "http://fenrir.com.mx/users/delete.php?";

  @override
  void initState() {
    StreamController<List<ModelUsers>> dataStream =
        StreamController<List<ModelUsers>>();
    reload();
    super.initState();
  }

  @override
  void dispose() {
    dataStream.close();
    super.dispose();
  }

  Future<Null> reload() async {
    GetFenrirUsers.getListUsers().then((res) async {
      dataStream.add(res);
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dataStream.stream,
      builder: (BuildContext context, AsyncSnapshot<List> snap) {
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return ConnectionWaiting();
          case ConnectionState.none:
            return ConnectionNone();
          case ConnectionState.active:
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Container(
                    width: Window(context).w(100),
                    height: Window(context).h(75),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: snap.data!.length == 0
                        ? TCentury('SIN REGISTOS', fontColor: Colored.primary)
                        : ListView.builder(
                            itemCount: snap.data!.length,
                            itemBuilder: (context, index) {
                              String user = snap.data![index].name;
                              String id = snap.data![index].id;
                              String type = snap.data![index].type;
                              return Container(
                                width: Window(context).w(100),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colored.primary, width: 1.5)),
                                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      child: TCentury(
                                        user,
                                        fontColor: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      width: Window(context).w(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            width: Window(context).w(12),
                                            height: Window(context).w(12),
                                            decoration: BoxDecoration(
                                                color: Colored.dark,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: IconButton(
                                              onPressed: () =>
                                                  onDelete(context, id),
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            width: Window(context).w(12),
                                            height: Window(context).w(12),
                                            decoration: BoxDecoration(
                                                color: Colored.dark,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: IconButton(
                                              onPressed: () => onUpdate(
                                                  context, id, user, type),
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => onCreate(context),
                          child: Button('AGREGAR'))
                    ],
                  )
                ],
              ),
            );
          case ConnectionState.done:
            return ConnectionDone();
        }
      },
    );
  }

  Future apiCreate(String name, String type) async {
    var url = '${API_create}name=${name}&type=${type}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await reload();
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

  Future apiUpdate(String id, String name, String type) async {
    var url = '${API_update}name=${name}&type=${type}&id=${id}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await reload();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se actualizo el registro con exito',
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

  Future apiDelete(String id) async {
    var url = '${API_delete}id=${id}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await reload();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se elimino el registro con exito',
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
                      Field(
                        typeCtrl,
                        hint: 'Ingresar tipo de usuario',
                        label: 'Tipo de usuario',
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

  void onUpdate(BuildContext context, String id, name, type) async {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController typeCtrl = TextEditingController();

    nameCtrl.text = name;
    typeCtrl.text = type;
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
                    'Editar registro',
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
                      Field(
                        typeCtrl,
                        hint: 'Ingresar tipo de usuario',
                        label: 'Tipo de usuario',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  apiUpdate(id, nameCtrl.text, typeCtrl.text),
                              child: Button('ACTUALIZAR')),
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

  void onDelete(BuildContext context, id) async {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(30),
            height: Window(context).w(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: TCentury(
                    '¿Desea eliminar el registro?',
                    fontColor: Colored.primary,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => apiDelete(id),
                          child: Button('ELIMINAR')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Button('CANCELAR'))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
