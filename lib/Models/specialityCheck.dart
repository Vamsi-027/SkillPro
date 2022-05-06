// To parse this JSON data, do
//
//     final specialityCheck = specialityCheckFromJson(jsonString);

import 'dart:convert';

SpecialityCheck specialityCheckFromJson(String str) =>
    SpecialityCheck.fromJson(json.decode(str));

String specialityCheckToJson(SpecialityCheck data) =>
    json.encode(data.toJson());

class SpecialityCheck {
  SpecialityCheck({
    required this.details,
  });

  Details details;

  factory SpecialityCheck.fromJson(Map<String, dynamic> json) =>
      SpecialityCheck(
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
      };
}

class Details {
  Details({
    required this.name,
    required this.speciality,
  });

  String name;
  String speciality;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        speciality: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "speciality": speciality,
      };
}
