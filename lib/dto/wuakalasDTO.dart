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
    required this.id,
    required this.sector,
    required this.autor,
    required this.fecha,
  });

  final int id;
  final String sector;
  final String autor;
  final String fecha;

  factory WuakalasDto.fromJson(Map<String, dynamic> json) => WuakalasDto(
        id: json["id"],
        sector: json["sector"],
        autor: json["autor"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sector": sector,
        "autor": autor,
        "fecha": fecha,
      };
}
