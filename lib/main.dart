import 'package:app/src/design/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FENRIR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colored.primary),
      initialRoute: '/',
      routes: getAplicationRoutes(),
    );
  }
}
