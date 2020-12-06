import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:que_paja/widgets/custom_boton.widget.dart';
import 'package:que_paja/widgets/custom_imput.widget.dart';
import 'package:que_paja/widgets/labels_login.widget.dart';
import 'package:que_paja/widgets/logo_login.widget.dart';

class RegisterPage extends StatelessWidget {
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
                LogoWidget(titulo: "SE UN PAJA!"),
                _FormContainer(),
                Labels(
                  ruta: 'login',
                  text1: "¿Ya tienes una cuenta?",
                  text2: "Ingresar ahora",
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
  final nameCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextField(
            hintText: "Nombre",
            icon: Icons.perm_identity,
            textController: nameCtrl,
          ),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            hintText: "Correo",
            icon: Icons.email_outlined,
            textController: emailCtrl,
          ),
          CustomTextField(
            textController: passCtrl,
            hintText: "Contraseña",
            icon: Icons.lock_outline,
            oscureText: true,
          ),
          SizedBox(height: 20),
          CustomBoton(onPressed: null, text: "Ingresar"),
        ],
      ),
    );
  }

  login() {
    print("Print login");
  }
}
