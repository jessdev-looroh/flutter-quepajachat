import 'dart:io';

class Enviroment {
  static String URL_API = Platform.isIOS
      ? "http://localhost:3000/api"
      // : "http://192.168.43.241:3000/api";
  // : "http://192.168.8.121:3000/api";
  : "http://192.168.1.16:3000/api";

  static String SOCKET_URL =
      Platform.isIOS ? "http://localhost:3000" 
      // : "http://192.168.43.241:3000";
  // : "http://192.168.8.121:3000";
  : "http://192.168.1.16:3000";
}
