// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  ResLogin({
    this.value,
    this.message,
    this.name,
    this.email,
    this.id,
  });

  int? value;
  String? message;
  String? name;
  String? email;
  String? id;

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
        value: json["value"],
        message: json["message"],
        name: json["name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "name": name,
        "email": email,
        "id": id,
      };
}
