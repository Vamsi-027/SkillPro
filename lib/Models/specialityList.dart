// To parse this JSON data, do
//
//     final specialitiesList = specialitiesListFromJson(jsonString);

import 'dart:convert';

SpecialitiesList specialitiesListFromJson(String str) =>
    SpecialitiesList.fromJson(json.decode(str));

String specialitiesListToJson(SpecialitiesList data) =>
    json.encode(data.toJson());

class SpecialitiesList {
  SpecialitiesList({
    required this.details,
  });

  List<Detail> details;

  factory SpecialitiesList.fromJson(Map<String, dynamic> json) =>
      SpecialitiesList(
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.specialityName,
    required this.specialityId,
  });

  String specialityName;
  int specialityId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        specialityName: json["specialityName"],
        specialityId: json["SpecialityId "],
      );

  Map<String, dynamic> toJson() => {
        "specialityName": specialityName,
        "SpecialityId ": specialityId,
      };
}
