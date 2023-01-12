// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

String userDtoToJson(UserDto? data) => json.encode(data!.toJson());

class UserDto {
  UserDto({
    required this.idUsuario,
    required this.email,
    required this.pass,
  });

  final int? idUsuario;
  final String? email;
  final String? pass;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        idUsuario: json["id_usuario"],
        email: json["email"],
        pass: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "email": email,
        "pass": pass,
      };
}
