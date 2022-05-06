// To parse this JSON data, do
//
//     final competencyDetails = competencyDetailsFromJson(jsonString);

import 'dart:convert';

List<CompetencyDetails> competencyDetailsFromJson(String str) =>
    List<CompetencyDetails>.from(
        json.decode(str).map((x) => CompetencyDetails.fromJson(x)));

String competencyDetailsToJson(List<CompetencyDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompetencyDetails {
  CompetencyDetails({
    required this.name,
    required this.regno,
    required this.self,
    required this.faculty,
    required this.competencynum,
    required this.competencyname,
  });

  String name;
  String regno;
  int self;
  int faculty;
  int competencynum;
  String competencyname;

  factory CompetencyDetails.fromJson(Map<String, dynamic> json) =>
      CompetencyDetails(
        name: json["name"],
        regno: json["regno"],
        self: json["self"],
        faculty: json["faculty"],
        competencynum: json["competencynum"],
        competencyname: json["competencyname"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "regno": regno,
        "self": self,
        "faculty": faculty,
        "competencynum": competencynum,
        "competencyname": competencyname,
      };
}
