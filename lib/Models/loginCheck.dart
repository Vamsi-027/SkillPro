// To parse this JSON data, do
//
//     final loginCheck = loginCheckFromJson(jsonString);

import 'dart:convert';

LoginCheck loginCheckFromJson(String str) =>
    LoginCheck.fromJson(json.decode(str));

String loginCheckToJson(LoginCheck data) => json.encode(data.toJson());

class LoginCheck {
  LoginCheck({
    required this.status,
    required this.role,
  });

  String status;
  String role;

  factory LoginCheck.fromJson(Map<String, dynamic> json) => LoginCheck(
        status: json["status"] == null ? null : json["status"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "role": role == null ? null : role,
      };
}
