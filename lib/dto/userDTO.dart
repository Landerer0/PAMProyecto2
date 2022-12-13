// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

String userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  UserDto({
    required this.id,
    required this.nombre,
    required this.email,
  });

  final int id;
  final String nombre;
  final String email;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "email": email,
      };
}
