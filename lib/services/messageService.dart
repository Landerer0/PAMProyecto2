import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto02/global.dart';

class MessageService {
  // Validar que los datos ingresados del usuario pertenecen al sistema
  Future<http.Response> validar(
      String login, String titulo, String desc) async {
    return await http.post(
      Uri.parse(Global.baseApiUrl + '/api/mensajes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'login': login, 'titulo': titulo, 'texto': desc}),
    );
  }

  // Agregar un mensaje en el sistema
  Future<http.Response> ingresoWuakala(String login, String sector,
      String descripcion, String imagen1, String imagen2) async {
    return await http.post(
        Uri.parse(Global.baseApiUrl + '/api/wuakalasApi/Postwuakalas/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'sector': sector,
          'descripcion': descripcion,
          'id_autor': Global.idUsuario.toString(),
          'base64Foto1': imagen1,
          'base64Foto2': imagen2
        }));
  }

  // Put Wuakala
  Future<http.Response> sigueAhiWuakala(String index) async {
    return await http.put(
      Uri.parse(Global.baseApiUrl + '/api/wuakalasApi/PutSigueAhi?id=' + index),
    );
  }

  Future<http.Response> yaNoEstaWuakala(String index) async {
    return await http.put(
      Uri.parse(Global.baseApiUrl + '/api/wuakalasApi/PutYanoEsta?id=' + index),
    );
  }

  Future<http.Response> getWuakala(int id) async {
    return await http.get(Uri.parse(
        Global.baseApiUrl + '/api/wuakalasApi/Getwuakala?id=' + id.toString()));
  }

  // Agregar un mensaje en el sistema
  Future<http.Response> ingresoComentario(
    int index,
    String descripcion,
  ) async {
    return await http.post(
        Uri.parse(Global.baseApiUrl + '/api/comentariosApi/Postcomentario'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id_wuakala': index.toString(),
          'descripcion': descripcion,
          'id_autor': Global.idUsuario.toString(),
        }));
  }
}
