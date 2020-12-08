// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:que_paja/models/message.model.dart';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    this.exito,
    this.mensajes,
  });

  bool exito;
  List<Mensaje> mensajes;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        exito: json["exito"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exito": exito,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}
