// To parse this JSON data, do
//
//     final studentEvaluation = studentEvaluationFromJson(jsonString);

import 'dart:convert';

List<StudentEvaluation> studentEvaluationFromJson(String str) =>
    List<StudentEvaluation>.from(
        json.decode(str).map((x) => StudentEvaluation.fromJson(x)));

String studentEvaluationToJson(List<StudentEvaluation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentEvaluation {
  StudentEvaluation({
    required this.compentencyevaluationid,
    required this.patientop,
    required this.date,
    required this.time,
    required this.self,
    required this.faculty,
  });

  int compentencyevaluationid;
  String patientop;
  String date;
  String time;
  int self;
  int faculty;

  factory StudentEvaluation.fromJson(Map<String, dynamic> json) =>
      StudentEvaluation(
        compentencyevaluationid: json["compentencyevaluationid"],
        patientop: json["patientop"],
        date: json["date"],
        time: json["time"],
        self: json["self"],
        faculty: json["faculty"],
      );

  Map<String, dynamic> toJson() => {
        "compentencyevaluationid": compentencyevaluationid,
        "patientop": patientop,
        "date": date,
        "time": time,
        "self": self,
        "faculty": faculty,
      };
}
