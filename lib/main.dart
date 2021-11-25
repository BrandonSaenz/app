import 'dart:async';

import 'package:app/src/design/widgets.dart';
import 'package:app/src/models/db_users.dart';
import 'package:app/src/models/get_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromRGBO(0, 0, 0, 1)),
      home: const MyHomePage(title: 'FENRIR WORKOUT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dataStream = StreamController<List<GetUser>>();

  loadPosts() async {
    GetFenrirUsers.getListUsers().then((res) async {
      dataStream.add(res);
      return res;
    });
  }

  @override
  void initState() {
    StreamController<List<GetUser>> dataStream =
        StreamController<List<GetUser>>();
    loadPosts();
    super.initState();
  }

  @override
  void dispose() {
    dataStream.close();
    super.dispose();
  }

  Future<Null> _handleRefresh() async {
    GetFenrirUsers.getListUsers().then((res) async {
      dataStream.add(res);
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        title: TCentury(widget.title),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        actions: <Widget>[
          IconButton(onPressed: _handleRefresh, icon: Icon(Icons.refresh))
        ],
      ),
      body: StreamBuilder(
        stream: dataStream.stream,
        builder: (BuildContext context, AsyncSnapshot<List> snap) {
          // if (snap.hasData) {
          //   return ListView.builder(
          //     itemCount: snap.data!.length,
          //     itemBuilder: (context, index) {
          //       var user = snap.data![index].name;
          //       return TCentury(user.toString());
          //     },
          //   );
          // } else {
          //   return CircularProgressIndicator();
          // }
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return const TCentury('Esperando Datos');
            case ConnectionState.none:
              return const TCentury('DATOS NONE');
            case ConnectionState.active:
              return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  var user = snap.data![index].name;
                  return TCentury(user.toString());
                },
              );
            case ConnectionState.done:
              return const TCentury('LA CONEXION TERMINO');
          }
        },
      ),
    );
  }
}
