// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
    required this.batch,
    required this.regno,
  });

  String name;
  String role;
  String phone;
  String email;
  String batch;
  String regno;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        role: json["role"],
        phone: json["phone"],
        email: json["email"],
        batch: json["batch"],
        regno: json["regno"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "phone": phone,
        "email": email,
        "batch": batch,
        "regno": regno,
      };
}
