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
    required this.id,
    required this.sector,
    required this.descripcion,
    required this.fechaPublicacion,
    required this.autor,
    required this.urlFoto1,
    required this.urlFoto2,
    required this.sigueAhi,
    required this.yaNoEsta,
    required this.comentarios,
  });

  final int id;
  final String sector;
  final String descripcion;
  final String fechaPublicacion;
  final String autor;
  final String urlFoto1;
  final String urlFoto2;
  final int sigueAhi;
  final int yaNoEsta;
  final List<Comentario> comentarios;

  factory WuakalaDto.fromJson(Map<String, dynamic> json) => WuakalaDto(
        id: json["id"],
        sector: json["sector"],
        descripcion: json["descripcion"],
        fechaPublicacion: json["fecha_publicacion"],
        autor: json["autor"],
        urlFoto1: json["url_foto1"],
        urlFoto2: json["url_foto2"],
        sigueAhi: json["sigue_ahi"],
        yaNoEsta: json["ya_no_esta"],
        comentarios: List<Comentario>.from(
            json["comentarios"].map((x) => Comentario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sector": sector,
        "descripcion": descripcion,
        "fecha_publicacion": fechaPublicacion,
        "autor": autor,
        "url_foto1": urlFoto1,
        "url_foto2": urlFoto2,
        "sigue_ahi": sigueAhi,
        "ya_no_esta": yaNoEsta,
        "comentarios": List<dynamic>.from(comentarios.map((x) => x.toJson())),
      };
}

class Comentario {
  Comentario({
    required this.id,
    required this.descripcion,
    required this.fechaComentario,
    required this.autor,
  });

  final int id;
  final String descripcion;
  final String fechaComentario;
  final String autor;

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json["id"],
        descripcion: json["descripcion"],
        fechaComentario: json["fecha_comentario"],
        autor: json["autor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "fecha_comentario": fechaComentario,
        "autor": autor,
      };
}
