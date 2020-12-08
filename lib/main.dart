import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:que_paja/routes/routes.dart';
import 'package:que_paja/services/auth.service.dart';
import 'package:que_paja/themes/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Que Paja !!!',
        initialRoute: 'loading',
        routes: appRoutes,
        theme: appTheme,
      ),
    );
  }
}
