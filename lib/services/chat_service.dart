import 'package:flutter/material.dart';
import 'package:que_paja/global/enviroment.dart';
import 'package:que_paja/models/chat_response.model.dart';
import 'package:que_paja/models/message.model.dart';
import 'package:que_paja/models/usuario.model.dart';
import 'package:http/http.dart' as http;
import 'package:que_paja/services/auth.service.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
      '${Enviroment.URL_API}/mensaje/${usuarioID}',
      headers: {'x-token': await AuthService.getToken()},
    );
    final mensajeResp = messageResponseFromJson(resp.body);
    return mensajeResp.mensajes;
  }
}
