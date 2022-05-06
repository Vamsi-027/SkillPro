// To parse this JSON data, do
//
//     final one2OneMeet = one2OneMeetFromJson(jsonString);

import 'dart:convert';

List<One2OneMeet> one2OneMeetFromJson(String str) => List<One2OneMeet>.from(
    json.decode(str).map((x) => One2OneMeet.fromJson(x)));

String one2OneMeetToJson(List<One2OneMeet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class One2OneMeet {
  One2OneMeet({
    required this.studentname,
    required this.competencyname,
    required this.studentid,
    required this.competencyevaluationId,
  });

  String studentname;
  String competencyname;
  String studentid;
  int competencyevaluationId;

  factory One2OneMeet.fromJson(Map<String, dynamic> json) => One2OneMeet(
        studentname: json["studentname"],
        competencyname: json["competencyname"],
        studentid: json["studentid"],
        competencyevaluationId: json["competencyevaluation_id"],
      );

  Map<String, dynamic> toJson() => {
        "studentname": studentname,
        "competencyname": competencyname,
        "studentid": studentid,
        "competencyevaluation_id": competencyevaluationId,
      };
}

// To parse this JSON data, do
//
//     final one2OneMeetStudent = one2OneMeetStudentFromJson(jsonString);

List<One2OneMeetStudent> one2OneMeetStudentFromJson(String str) =>
    List<One2OneMeetStudent>.from(
        json.decode(str).map((x) => One2OneMeetStudent.fromJson(x)));

String one2OneMeetStudentToJson(List<One2OneMeetStudent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class One2OneMeetStudent {
  One2OneMeetStudent({
    required this.facultyname,
    required this.competencyname,
    required this.meettime,
    required this.competencyevaluationId,
    required this.evaluationtype,
  });

  String facultyname;
  String competencyname;
  String meettime;
  int competencyevaluationId;
  String evaluationtype;

  factory One2OneMeetStudent.fromJson(Map<String, dynamic> json) =>
      One2OneMeetStudent(
        facultyname: json["facultyname"] == null ? null : json["facultyname"],
        competencyname:
            json["competencyname"] == null ? null : json["competencyname"],
        meettime: json["meettime"] == null ? null : json["meettime"],
        competencyevaluationId: json["competencyevaluation_id"] == null
            ? null
            : json["competencyevaluation_id"],
        evaluationtype:
            json["evaluationtype"] == null ? null : json["evaluationtype"],
      );

  Map<String, dynamic> toJson() => {
        "facultyname": facultyname == null ? null : facultyname,
        "competencyname": competencyname == null ? null : competencyname,
        "meettime": meettime == null ? null : meettime,
        "competencyevaluation_id":
            competencyevaluationId == null ? null : competencyevaluationId,
        "evaluationtype": evaluationtype == null ? null : evaluationtype,
      };
}
