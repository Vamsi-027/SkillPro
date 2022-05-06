// To parse this JSON data, do
//
//     final competencyList = competencyListFromJson(jsonString);

import 'dart:convert';

CompetencyList competencyListFromJson(String str) =>
    CompetencyList.fromJson(json.decode(str));

String competencyListToJson(CompetencyList data) => json.encode(data.toJson());

class CompetencyList {
  CompetencyList({
    required this.details,
  });

  List<Detail>? details;

  factory CompetencyList.fromJson(Map<String, dynamic> json) => CompetencyList(
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details == null
            ? null
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.competencyname,
    required this.competencyid,
  });

  String competencyname;
  int competencyid;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        competencyname:
            json["competencyname"] == null ? null : json["competencyname"],
        competencyid:
            json["competencyid"] == null ? null : json["competencyid"],
      );

  Map<String, dynamic> toJson() => {
        "competencyname": competencyname == null ? null : competencyname,
        "competencyid": competencyid == null ? null : competencyid,
      };
}

List<StudentcompetencyList> studentcompetencyListFromJson(String str) =>
    List<StudentcompetencyList>.from(
        json.decode(str).map((x) => StudentcompetencyList.fromJson(x)));

String studentcompetencyListToJson(List<StudentcompetencyList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentcompetencyList {
  StudentcompetencyList({
    required this.competencyid,
    required this.competencyname,
    required this.self,
    required this.faculty,
  });

  int competencyid;
  String competencyname;
  int self;
  int faculty;

  factory StudentcompetencyList.fromJson(Map<String, dynamic> json) =>
      StudentcompetencyList(
        competencyid: json["competencyid"],
        competencyname: json["competencyname"],
        self: json["self"],
        faculty: json["faculty"],
      );

  Map<String, dynamic> toJson() => {
        "competencyid": competencyid,
        "competencyname": competencyname,
        "self": self,
        "faculty": faculty,
      };
}
