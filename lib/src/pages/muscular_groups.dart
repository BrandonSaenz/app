import 'dart:async';
import 'package:app/src/API/controllers.dart';
import 'package:app/src/API/models.dart';
import 'package:app/src/design/theme/theme_data.dart';
import 'package:app/src/design/widgets/input.dart';
import 'package:app/src/design/widgets/components.dart';
import 'package:app/src/pages/routines.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MuscularPage extends StatefulWidget {
  final AdvancedDrawerController? drawerCtrl;
  MuscularPage(this.drawerCtrl, {Key? key}) : super(key: key);

  @override
  _MuscularPageState createState() => _MuscularPageState();
}

class _MuscularPageState extends State<MuscularPage> {
  final dataStream = StreamController<List<ModelMuscularGroups>>();
  AdvancedDrawerController drawerCtrl = AdvancedDrawerController();

  String API_create = "http://fenrir.com.mx/muscular_groups/post.php?";
  String API_update = "http://fenrir.com.mx/muscular_groups/update.php?";
  String API_delete = "http://fenrir.com.mx/muscular_groups/delete.php?";

  loadPosts() async {
    GetMuscularGroups.getList().then((res) async {
      dataStream.add(res);
      print('LOAD GET USERS ${res.length}');
      return res;
    });
  }

  void _handleHomePageButtonPressed() {
    drawerCtrl.showDrawer();
  }

  goRoutines(String id_muscular_groups) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoutinesPage(id_muscular_groups)),
    );
  }

  @override
  void initState() {
    drawerCtrl = widget.drawerCtrl!;
    StreamController<List<ModelMuscularGroups>> dataStream =
        StreamController<List<ModelMuscularGroups>>();
    loadPosts();
    super.initState();
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
      backgroundColor: Colored.black,
      // appBar: AppBar(
      //     backgroundColor: Colored.primary,
      //     title: Container(
      //       width: Window(context).w(100),
      //       height: 30,
      //       child: TCentury(
      //         'MUSCULAR GROUPS',
      //         aling: TextAlign.left,
      //       ),
      //     ),
      //     leading: IconButton(
      //       onPressed: _handleHomePageButtonPressed,
      //       icon: ValueListenableBuilder<AdvancedDrawerValue>(
      //         valueListenable: drawerCtrl,
      //         builder: (_, value, __) {
      //           return AnimatedSwitcher(
      //             duration: const Duration(milliseconds: 250),
      //             child: Icon(
      //               value.visible ? Icons.clear : Icons.menu,
      //               key: ValueKey<bool>(value.visible),
      //             ),
      //           );
      //         },
      //       ),
      //     )),
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
                backgroundColor: Colored.black,
                body: Column(
                  children: [
                    Container(
                      width: Window(context).w(100),
                      height: Window(context).h(75),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: snap.data!.length == 0
                          ? TCentury('SIN REGISTOS')
                          : ListView.builder(
                              itemCount: snap.data!.length,
                              itemBuilder: (context, index) {
                                String id_muscular_groups =
                                    snap.data![index].id;
                                String name = snap.data![index].name;
                                return name != 'null'
                                    ? muscule_group(name, id_muscular_groups)
                                    : Container(
                                        width: Window(context).w(100),
                                        height: Window(context).h(70),
                                        child: Center(
                                          child: TCentury('SIN REGISTROS'),
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

  Widget muscule_group(String name, id_muscular_groups) {
    return GestureDetector(
      onTap: () => goRoutines(id_muscular_groups),
      child: Container(
        width: Window(context).w(100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colored.dark),
        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: TCentury(name),
            ),
            // Container(
            //   width: Window(context).w(30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            //         width: Window(context).w(12),
            //         height: Window(context).w(12),
            //         decoration: BoxDecoration(
            //             color: Colored.dark,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: IconButton(
            //           onPressed: () => onDelete(context, id_muscular_groups),
            //           icon: Icon(
            //             Icons.remove,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            //         width: Window(context).w(12),
            //         height: Window(context).w(12),
            //         decoration: BoxDecoration(
            //             color: Colored.dark,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: IconButton(
            //           onPressed: () =>
            //               onUpdate(context, id_muscular_groups, name),
            //           icon: Icon(
            //             Icons.edit,
            //             color: Colors.white,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Future apiCreate(String name, String type) async {
    var url = '${API_create}name=${name}&type=${type}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await loadPosts();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se creo el registro con exito',
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      await loadPosts();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'ERROR',
        message: '',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  Future apiUpdate(String id, name) async {
    var url = '${API_update}name=${name}&id=${id}';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      await loadPosts();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se actualizo el registro con exito',
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      await loadPosts();
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
      await loadPosts();
      Navigator.pop(context);
      await Flushbar(
        backgroundColor: Colors.green,
        title: 'SUCCESS',
        message: 'Se elimino el registro con exito',
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      await loadPosts();
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
                  title: TCentury('Crear registro'),
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

  void onUpdate(BuildContext context, String id, name) async {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController typeCtrl = TextEditingController();

    nameCtrl.text = name;

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
                  title: TCentury('Editar registro'),
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
                              onPressed: () => apiUpdate(id, nameCtrl.text),
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
                  title: TCentury('¿Desea eliminar el registro?'),
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
