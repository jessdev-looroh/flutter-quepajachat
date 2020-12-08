import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:que_paja/helpers/alerta.dart';
import 'package:que_paja/services/auth.service.dart';
import 'package:que_paja/services/socket.service.dart';
import 'package:que_paja/widgets/custom_boton.widget.dart';
import 'package:que_paja/widgets/custom_imput.widget.dart';
import 'package:que_paja/widgets/labels_login.widget.dart';
import 'package:que_paja/widgets/logo_login.widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(titulo: "QUE PAJA!!!"),
                _FormContainer(),
                Labels(
                  ruta: 'register',
                  text1: "¿No tienes cuenta?",
                  text2: "Crea una ahora!",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Términos y condiciones de uso",
                      style: TextStyle(fontWeight: FontWeight.w200)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormContainer extends StatefulWidget {
  @override
  __FormContainerState createState() => __FormContainerState();
}

class __FormContainerState extends State<_FormContainer> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServce = Provider.of<AuthService>(context);
    return Container(
      child: Column(
        children: [
          CustomTextField(
            enabled: !authServce.isLogeando,
            keyboardType: TextInputType.emailAddress,
            hintText: "Correo",
            icon: Icons.email_outlined,
            textController: emailCtrl,
          ),
          CustomTextField(
            enabled: !authServce.isLogeando,
            textController: passCtrl,
            hintText: "Contraseña",
            icon: Icons.lock_outline,
            oscureText: true,
          ),
          SizedBox(height: 20),
          CustomBoton(
            onPressed: authServce.isLogeando ? null : login,
            text: "Ingresar",
          ),
        ],
      ),
    );
  }

  login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    authService.isLogeando = true;
    FocusScope.of(context).unfocus();
    final loginOk = await authService.login(emailCtrl.text, passCtrl.text);
    authService.isLogeando = false;

    if (loginOk) {
      socketService.connect();
      Navigator.pushReplacementNamed(context, "usuarios");
    } else {
      mostrarAlerta(
          context, "Login incorrecto", "Rebice sus credenciales nuevamente.");
    }
  }
}
