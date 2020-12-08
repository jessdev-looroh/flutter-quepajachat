import 'package:flutter/material.dart';
import 'package:que_paja/global/enviroment.dart';
import 'package:que_paja/services/auth.service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  List<String> _debugConsole = [];

  // SocketService() {
  //   this._initConfig();
  // }

  List<String> get debugConsole => this._debugConsole;
  set debugConle(String message) {
    this._debugConsole.add(message);
    notifyListeners();
  }

  set serverStatus(ServerStatus status) {
    this._serverStatus = status;
    notifyListeners();
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  void connect() async {
    final token = await AuthService.getToken();
    this._socket = IO.io(
      '${Enviroment.SOCKET_URL}',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNew()
          .setExtraHeaders({'x-token': token})
          .build(),
    );
    this._socket.onConnect((_) {
      print('connect');
      serverStatus = ServerStatus.Online;
    });
    this._socket.onReconnecting((data) {
      print("reconectando");
      serverStatus = ServerStatus.Connecting;
    });
    this._socket.onError((data) {
      print(data);
    });

    this._socket.onDisconnect((_) => {
          serverStatus = ServerStatus.Offline,
          debugConle = "Desconectado",
          print("Desconectado")
        });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}

// keytool -genkey -v -keystore C:\Users\Pro-t\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
