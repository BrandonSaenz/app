import 'dart:async';
import 'package:app/src/API/controllers.dart';
import 'package:app/src/API/models.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:app/src/design/widgets/input.dart';
import 'package:app/src/design/widgets/components.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class RoutinesPage extends StatefulWidget {
  String? id_muscular_groups;
  RoutinesPage(this.id_muscular_groups, {Key? key}) : super(key: key);

  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  final dataStream = StreamController<List<ModelRoutines>>();
  late String id_muscular_groups;
  AdvancedDrawerController drawerCtrl = AdvancedDrawerController();

  String API_create = "http://fenrir.com.mx/routines/post.php?";
  String API_update = "http://fenrir.com.mx/routines/update.php?";
  String API_delete = "http://fenrir.com.mx/routines/delete.php?";

  @override
  void initState() {
    id_muscular_groups = widget.id_muscular_groups!;
    StreamController<List<ModelRoutines>> dataStream =
        StreamController<List<ModelRoutines>>();
    loadPosts(id_muscular_groups);
    super.initState();
  }

  loadPosts(String id_muscular_groups) async {
    GetRoutines.getList(id_muscular_groups).then((res) async {
      dataStream.add(res);
      print('LOAD GET USERS ${res.length}');
      return res;
    });
  }

  @override
  void dispose() {
    dataStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colored.dark,
          title: Container(
            width: Window(context).w(100),
            height: 30,
            child: TCentury(
              'ROUTINES',
              aling: TextAlign.left,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp),
          )),
      body: StreamBuilder(
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
                                String id = snap.data![index].id;
                                String title = snap.data![index].title;
                                String description =
                                    snap.data![index].description;
                                String num_circuitos =
                                    snap.data![index].num_circuitos;

                                return title != 'null'
                                    ? Container(
                                        width: Window(context).w(100),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colored.primary,
                                                width: 1.5)),
                                        margin:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Window(context).w(50),
                                              height: Window(context).w(14),
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: TCentury(
                                                title,
                                                aling: TextAlign.left,
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
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                    width:
                                                        Window(context).w(12),
                                                    height:
                                                        Window(context).w(12),
                                                    decoration: BoxDecoration(
                                                        color: Colored.dark,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                    width:
                                                        Window(context).w(12),
                                                    height:
                                                        Window(context).w(12),
                                                    decoration: BoxDecoration(
                                                        color: Colored.dark,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: IconButton(
                                                      onPressed: () => onUpdate(
                                                          context,
                                                          id,
                                                          title,
                                                          description,
                                                          num_circuitos),
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
                                      )
                                    : Container(
                                        width: Window(context).w(100),
                                        height: Window(context).h(70),
                                        child: Center(
                                          child: TCentury('SIN REGISTROS',
                                              fontColor: Colored.primary),
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
      ),
    );
  }

  Future apiCreate(String title, description, num_circuitos) async {
    var url =
        '${API_create}&title=${title}&description=${description}&num_circuitos=${num_circuitos}&id_muscular_groups=${id_muscular_groups}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await loadPosts(id_muscular_groups);
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se creo el registro con exito',
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      await loadPosts(id_muscular_groups);
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'ERROR',
        message: '',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  Future apiUpdate(String id, title, description, num_circuitos) async {
    var url =
        '${API_update}id=${id}&title=${title}&description=${description}&num_circuitos=${num_circuitos}&id_muscular_groups=${id_muscular_groups}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await loadPosts(id_muscular_groups);
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
      await loadPosts(id_muscular_groups);
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
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController descriptionCtrl = TextEditingController();
    TextEditingController circuitosCtrl = TextEditingController();

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
                      Container(
                        width: Window(context).w(100),
                        height: Window(context).h(30),
                        child: ListView(
                          children: [
                            Field(
                              titleCtrl,
                              hint: 'Ingresar titulo',
                              label: 'Titulo',
                            ),
                            Field(
                              descriptionCtrl,
                              hint: 'Ingresar descripcion',
                              label: 'Descripcion',
                            ),
                            Field(
                              circuitosCtrl,
                              hint: 'N Circuitos',
                              label: 'Cantidad de circuitos',
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () => apiCreate(titleCtrl.text,
                                  descriptionCtrl.text, circuitosCtrl.text),
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

  void onUpdate(
      BuildContext context, String id, title, description, circuitos) async {
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController descriptionCtrl = TextEditingController();
    TextEditingController circuitosCtrl = TextEditingController();

    titleCtrl.text = title;
    descriptionCtrl.text = description;
    circuitosCtrl.text = circuitos;
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
                        titleCtrl,
                        hint: 'Ingresar titulo',
                        label: 'Titulo',
                      ),
                      Field(
                        descriptionCtrl,
                        hint: 'Ingresar descripcion',
                        label: 'Descripcion',
                      ),
                      Field(
                        circuitosCtrl,
                        hint: 'N Circuitos',
                        label: 'Cantidad de circuitos',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () => apiUpdate(id, titleCtrl.text,
                                  descriptionCtrl.text, circuitosCtrl.text),
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
