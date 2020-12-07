import 'package:flutter/material.dart';
import 'package:que_paja/routes/routes.dart';
import 'package:que_paja/themes/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Que Paja !!!',
      initialRoute: 'chat',
      routes: appRoutes,
      theme: appTheme,
    );
  }
}
