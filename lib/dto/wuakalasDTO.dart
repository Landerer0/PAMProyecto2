// To parse this JSON data, do
//
//     final wuakalasDto = wuakalasDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<WuakalasDto> wuakalasDtoFromJson(String str) => List<WuakalasDto>.from(
    json.decode(str).map((x) => WuakalasDto.fromJson(x)));

String wuakalasDtoToJson(List<WuakalasDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WuakalasDto {
  WuakalasDto({
    required this.idWuakala,
    required this.sector,
    required this.autor,
    required this.fecha,
  });

  final int idWuakala;
  final String sector;
  final String autor;
  final String fecha;

  factory WuakalasDto.fromJson(Map<String, dynamic> json) => WuakalasDto(
        idWuakala: json["id_wuakala"],
        sector: json["sector"],
        autor: json["autor"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id_wuakala": idWuakala,
        "sector": sector,
        "autor": autor,
        "fecha": fecha,
      };
}

enum Autor { LUCAS }

final autorValues = EnumValues({"Lucas": Autor.LUCAS});

enum Sector { MI_CASA }

final sectorValues = EnumValues({"Mi Casa": Sector.MI_CASA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
