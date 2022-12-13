import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto02/global.dart';

class LoginService {
  // Validar que los datos ingresados del usuario pertenecen al sistema
  Future<http.Response> validar(String email, String pass) async {
    return await http.get(
      Uri.parse(Global.baseApiUrl +
          '/api/usuariosApi/Getusuario?email=' +
          email +
          '&password=' +
          pass),
    );
  }

  // Registrar un usuario en el sistema
  Future<http.Response> registroUsuario(String login, String pass) async {
    return await http.post(
      Uri.parse(
          Global.baseApiUrl + '/api/Usuarios?login=' + login + '&pass=' + pass),
    );
  }
}
