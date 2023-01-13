import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto02/global.dart';

class MessageService {
  // Agregar un mensaje en el sistema
  Future<http.Response> ingresoWuakala(String login, String sector,
      String descripcion, String imagen1, String imagen2) async {
    return await http.post(Uri.parse(Global.baseApiUrl + '/wuakalas'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'sector': sector,
          'descripcion': descripcion,
          'autor': Global.idUsuario.toString(),
          'urlFoto1': imagen1,
          'urlFoto2': imagen2
        }));
  }

  // Put Wuakala
  Future<http.Response> sigueAhiWuakala(String index) async {
    return await http.put(
      Uri.parse(
          Global.baseApiUrl + '/wuakala?idWuakala=' + index + '&sigueAhi=5'),
    );
  }

  Future<http.Response> yaNoEstaWuakala(String index) async {
    return await http.put(
      Uri.parse(
          Global.baseApiUrl + '/wuakala?idWuakala=' + index + '&yaNoEsta=5'),
    );
  }

  Future<http.Response> getWuakala(int id) async {
    return await http.get(
        Uri.parse(Global.baseApiUrl + '/wuakala?idWuakala=' + id.toString()));
  }

  // Agregar un mensaje en el sistema
  Future<http.Response> ingresoComentario(
    int index,
    String descripcion,
  ) async {
    return await http.post(
        Uri.parse(Global.baseApiUrl + '/wuakala?idWuakala=' + index.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'descripcion': descripcion,
          'autor': Global.idUsuario.toString(),
        }));
  }
}
