import 'package:flutter/material.dart';
import 'package:que_paja/pages/chat.page.dart';
import 'package:que_paja/pages/loading.page.dart';
import 'package:que_paja/pages/login.page.dart';
import 'package:que_paja/pages/register.page.dart';
import 'package:que_paja/pages/usuarios.page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
