import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:que_paja/pages/usuarios.page.dart';
import 'package:que_paja/services/auth.service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text("Espere..."),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, "login");
    }
  }
}
