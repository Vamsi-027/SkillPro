// To parse this JSON data, do
//
//     final seeEvaluationForm = seeEvaluationFormFromJson(jsonString);

import 'dart:convert';

SeeEvaluationForm seeEvaluationFormFromJson(String str) =>
    SeeEvaluationForm.fromJson(json.decode(str));

String seeEvaluationFormToJson(SeeEvaluationForm data) =>
    json.encode(data.toJson());

class SeeEvaluationForm {
  SeeEvaluationForm({
    required this.compevaluationid,
    required this.patientop,
    required this.date,
    required this.time,
    required this.studentname,
    required this.facultyname,
    required this.criteriadetails,
    required this.meettime,
  });

  int compevaluationid;
  String patientop;
  String date;
  String time;
  String studentname;
  String facultyname;
  List<Criteriadetail> criteriadetails;
  String meettime;

  factory SeeEvaluationForm.fromJson(Map<String, dynamic> json) =>
      SeeEvaluationForm(
        compevaluationid: json["compevaluationid"],
        patientop: json["patientop"],
        date: json["date"],
        time: json["time"],
        studentname: json["studentname"],
        facultyname: json["facultyname"],
        criteriadetails: List<Criteriadetail>.from(
            json["criteriadetails"].map((x) => Criteriadetail.fromJson(x))),
        meettime: json["meettime"],
      );

  Map<String, dynamic> toJson() => {
        "compevaluationid": compevaluationid,
        "patientop": patientop,
        "date": date,
        "time": time,
        "studentname": studentname,
        "facultyname": facultyname,
        "criteriadetails":
            List<dynamic>.from(criteriadetails.map((x) => x.toJson())),
        "meettime": meettime,
      };
}

class Criteriadetail {
  Criteriadetail({
    required this.criteiaid,
    required this.criteriaqs,
    required this.optionmatter,
    required this.optionval,
    required this.refermatter,
  });

  int criteiaid;
  String criteriaqs;
  String optionmatter;
  int optionval;
  String refermatter;

  factory Criteriadetail.fromJson(Map<String, dynamic> json) => Criteriadetail(
        criteiaid: json["criteiaid"],
        criteriaqs: json["criteriaqs"],
        optionmatter: json["optionmatter"],
        optionval: json["optionval"],
        refermatter: json["refermatter"],
      );

  Map<String, dynamic> toJson() => {
        "criteiaid": criteiaid,
        "criteriaqs": criteriaqs,
        "optionmatter": optionmatter,
        "optionval": optionval,
        "refermatter": refermatter,
      };
}

// To parse this JSON data, do
//
//     final seeStudentEvaluation = seeStudentEvaluationFromJson(jsonString);

SeeStudentEvaluation seeStudentEvaluationFromJson(String str) =>
    SeeStudentEvaluation.fromJson(json.decode(str));

String seeStudentEvaluationToJson(SeeStudentEvaluation data) =>
    json.encode(data.toJson());

class SeeStudentEvaluation {
  SeeStudentEvaluation({
    required this.compevaluationid,
    required this.patientop,
    required this.date,
    required this.time,
    required this.studentname,
    required this.facultyname,
    required this.criteriadetails,
    required this.meettime,
  });

  int compevaluationid;
  String patientop;
  String date;
  String time;
  String studentname;
  String facultyname;
  List<Criteriadetail> criteriadetails;
  String meettime;

  factory SeeStudentEvaluation.fromJson(Map<String, dynamic> json) =>
      SeeStudentEvaluation(
        compevaluationid: json["compevaluationid"],
        patientop: json["patientop"],
        date: json["date"],
        time: json["time"],
        studentname: json["studentname"],
        facultyname: json["facultyname"],
        criteriadetails: List<Criteriadetail>.from(
            json["criteriadetails"].map((x) => Criteriadetail.fromJson(x))),
        meettime: json["meettime"],
      );

  Map<String, dynamic> toJson() => {
        "compevaluationid": compevaluationid,
        "patientop": patientop,
        "date": date,
        "time": time,
        "studentname": studentname,
        "facultyname": facultyname,
        "criteriadetails":
            List<dynamic>.from(criteriadetails.map((x) => x.toJson())),
        "meettime": meettime,
      };
}
