// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:que_paja/models/usuario.model.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.exito,
    this.usuario,
    this.token,
  });

  bool exito;
  Usuario usuario;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        exito: json["exito"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "exito": exito,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
