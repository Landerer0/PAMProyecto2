// To parse this JSON data, do
//
//     final wuakalaDto = wuakalaDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WuakalaDto wuakalaDtoFromJson(String str) =>
    WuakalaDto.fromJson(json.decode(str));

String wuakalaDtoToJson(WuakalaDto data) => json.encode(data.toJson());

class WuakalaDto {
  WuakalaDto({
    required this.idWuakala,
    required this.sector,
    required this.descripcion,
    required this.autor,
    required this.fecha,
    required this.urlFoto1,
    required this.urlFoto2,
    required this.sigueAhi,
    required this.yaNoEsta,
    required this.comentarios,
  });

  final int idWuakala;
  final String sector;
  final String descripcion;
  final String autor;
  final String fecha;
  final String urlFoto1;
  final String urlFoto2;
  final int sigueAhi;
  final int yaNoEsta;
  final List<Comentario> comentarios;

  factory WuakalaDto.fromJson(Map<String, dynamic> json) => WuakalaDto(
        idWuakala: json["id_wuakala"],
        sector: json["sector"],
        descripcion: json["descripcion"],
        autor: json["autor"],
        fecha: json["fecha"],
        urlFoto1: json["url_foto1"],
        urlFoto2: json["url_foto2"],
        sigueAhi: json["sigue_ahi"],
        yaNoEsta: json["ya_no_esta"],
        comentarios: json["comentarios"] == null
            ? []
            : List<Comentario>.from(
                json["comentarios"].map((x) => Comentario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_wuakala": idWuakala,
        "sector": sector,
        "descripcion": descripcion,
        "autor": autor,
        "fecha": fecha,
        "url_foto1": urlFoto1,
        "url_foto2": urlFoto2,
        "sigue_ahi": sigueAhi,
        "ya_no_esta": yaNoEsta,
        "comentarios": comentarios == null
            ? []
            : List<dynamic>.from(comentarios.map((x) => x.toJson())),
      };
}

class Comentario {
  Comentario({
    required this.idWuakala,
    required this.descripcion,
    required this.autor,
    required this.fecha,
  });

  final int idWuakala;
  final String descripcion;
  final String autor;
  final String fecha;

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        idWuakala: json["id_wuakala"],
        descripcion: json["descripcion"],
        autor: json["autor"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id_wuakala": idWuakala,
        "descripcion": descripcion,
        "autor": autor,
        "fecha": fecha,
      };
}
