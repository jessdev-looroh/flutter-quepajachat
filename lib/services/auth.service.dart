import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:que_paja/global/enviroment.dart';
import 'package:que_paja/models/login_response.model.dart';
import 'package:que_paja/models/usuario.model.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _logeando = false;
  final _storage = new FlutterSecureStorage();

  bool get isLogeando => this._logeando;
  set isLogeando(bool value) {
    this._logeando = value;
    notifyListeners();
  }

  //GETTERS DEL TOKEN STATICOS

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    final data = {"email": email, "password": password};
    final resp = await http.post("${Enviroment.URL_API}/login",
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    // print(resp.statusCode);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http
        .get("${Enviroment.URL_API}/login/renew", headers: {'x-token': token});

    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future<bool> registrar(
      {@required String email,
      @required String password,
      @required String nombre}) async {
    final body = {"email": email, "password": password, "nombre": nombre};
    final resp = await http.post("${Enviroment.URL_API}/login/new",
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});

    print(resp.body);
    print(resp.statusCode);

    if (resp.statusCode == 201) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
