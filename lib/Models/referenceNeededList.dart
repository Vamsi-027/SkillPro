// To parse this JSON data, do
//
//     final referenceNeeded = referenceNeededFromJson(jsonString);

import 'dart:convert';

List<ReferenceNeeded> referenceNeededFromJson(String str) =>
    List<ReferenceNeeded>.from(
        json.decode(str).map((x) => ReferenceNeeded.fromJson(x)));

String referenceNeededToJson(List<ReferenceNeeded> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferenceNeeded {
  ReferenceNeeded({
    required this.studentname,
    required this.competencyname,
    required this.studentid,
    required this.criteriaqs,
    required this.criteriaid,
    required this.competencyevaluationId,
  });

  String studentname;
  String competencyname;
  String studentid;
  String criteriaqs;
  int criteriaid;
  int competencyevaluationId;

  factory ReferenceNeeded.fromJson(Map<String, dynamic> json) =>
      ReferenceNeeded(
        studentname: json["studentname"],
        competencyname: json["competencyname"],
        studentid: json["studentid"],
        criteriaqs: json["criteriaqs"],
        criteriaid: json["criteriaid"],
        competencyevaluationId: json["competencyevaluation_id"],
      );

  Map<String, dynamic> toJson() => {
        "studentname": studentname,
        "competencyname": competencyname,
        "studentid": studentid,
        "criteriaqs": criteriaqs,
        "criteriaid": criteriaid,
        "competencyevaluation_id": competencyevaluationId,
      };
}

List<ReferenceStudentList> referenceStudentListFromJson(String str) =>
    List<ReferenceStudentList>.from(
        json.decode(str).map((x) => ReferenceStudentList.fromJson(x)));

String referenceStudentListToJson(List<ReferenceStudentList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferenceStudentList {
  ReferenceStudentList({
    required this.facultyname,
    required this.competencyname,
    required this.reference,
    required this.competencyevaluationId,
    required this.evaluationtype,
    required this.criteriaid,
    required this.criteriaqs,
  });

  String facultyname;
  String competencyname;
  String reference;
  int competencyevaluationId;
  String evaluationtype;
  int criteriaid;
  String criteriaqs;

  factory ReferenceStudentList.fromJson(Map<String, dynamic> json) =>
      ReferenceStudentList(
        facultyname: json["facultyname"],
        competencyname: json["competencyname"],
        reference: json["reference"],
        competencyevaluationId: json["competencyevaluation_id"],
        evaluationtype: json["evaluationtype"],
        criteriaid: json["criteriaid"],
        criteriaqs: json["criteriaqs"],
      );

  Map<String, dynamic> toJson() => {
        "facultyname": facultyname,
        "competencyname": competencyname,
        "reference": reference,
        "competencyevaluation_id": competencyevaluationId,
        "evaluationtype": evaluationtype,
        "criteriaid": criteriaid,
        "criteriaqs": criteriaqs,
      };
}
