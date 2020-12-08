import 'package:http/http.dart' as http;
import 'package:que_paja/global/enviroment.dart';
import 'package:que_paja/models/usuario.model.dart';
import 'package:que_paja/models/usuario_response.model.dart';
import 'package:que_paja/services/auth.service.dart';

class UsuarioService {
  Future<List<Usuario>> getUsuarios() async {
    final resp = await http.get("${Enviroment.URL_API}/usuario", headers: {
      'Content-Type': "application/json",
      'x-token': await AuthService.getToken()
    });

    final usuarioResponse = usuarioResponseFromJson(resp.body);
    return usuarioResponse.usuarios;
  }
}
