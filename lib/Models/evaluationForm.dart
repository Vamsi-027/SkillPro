// To parse this JSON data, do
//
//     final evaluationForm = evaluationFormFromJson(jsonString);

import 'dart:convert';

EvaluationForm evaluationFormFromJson(String str) =>
    EvaluationForm.fromJson(json.decode(str));

String evaluationFormToJson(EvaluationForm data) => json.encode(data.toJson());

class EvaluationForm {
  EvaluationForm({
    required this.compevaluationid,
    required this.patientop,
    required this.date,
    required this.time,
    required this.studentname,
    required this.facultyname,
    required this.criteriadetails,
  });

  int compevaluationid;
  String patientop;
  String date;
  String time;
  String studentname;
  String facultyname;
  List<Criteriadetail> criteriadetails;

  factory EvaluationForm.fromJson(Map<String, dynamic> json) => EvaluationForm(
        compevaluationid: json["compevaluationid"],
        patientop: json["patientop"],
        date: json["date"],
        time: json["time"],
        studentname: json["studentname"],
        facultyname: json["facultyname"],
        criteriadetails: List<Criteriadetail>.from(
            json["criteriadetails"].map((x) => Criteriadetail.fromJson(x))),
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
      };
}

class Criteriadetail {
  Criteriadetail({
    required this.criteiaid,
    required this.criteriaqs,
    required this.option0,
    required this.option1,
    required this.option2,
  });

  int criteiaid;
  String criteriaqs;
  String option0;
  String option1;
  String option2;

  factory Criteriadetail.fromJson(Map<String, dynamic> json) => Criteriadetail(
        criteiaid: json["criteiaid"],
        criteriaqs: json["criteriaqs"],
        option0: json["option0"],
        option1: json["option1"],
        option2: json["option2"],
      );

  Map<String, dynamic> toJson() => {
        "criteiaid": criteiaid,
        "criteriaqs": criteriaqs,
        "option0": option0,
        "option1": option1,
        "option2": option2,
      };
}
