// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

import 'package:chat/src/models/usuario.dart';

RegisterUser registerUserFromJson(String str) => RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
    RegisterUser({
        this.ok,
        required this.usuario,
        this.token,
    });

    bool? ok;
    Usuario usuario;
    String? token;

    factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}
