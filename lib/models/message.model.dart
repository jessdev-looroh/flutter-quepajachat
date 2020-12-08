// To parse this JSON data, do
//
//     final mensaje = mensajeFromJson(jsonString);

import 'dart:convert';

Mensaje mensajeFromJson(String str) => Mensaje.fromJson(json.decode(str));

String mensajeToJson(Mensaje data) => json.encode(data.toJson());

class Mensaje {
  Mensaje({
    this.id,
    this.de,
    this.para,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["_id"],
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
