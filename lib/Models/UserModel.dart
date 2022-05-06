
import 'dart:convert';

TableDetails tableDetailsFromJson(String str) => TableDetails.fromJson(json.decode(str));

String tableDetailsToJson(TableDetails data) => json.encode(data.toJson());

class TableDetails {
  int compentencyevaluationid;
  String patientop;
  String date;
  String time;
  int self;
  int faculty;

  TableDetails(
      {
        required this.compentencyevaluationid,
        required this.patientop,
        required this.date,
        required this.time,
        required this.self,
        required this.faculty,
      });

  factory TableDetails.fromJson(Map<String, dynamic> json) {
    return TableDetails(
      compentencyevaluationid : json['compentencyevaluationid'] as int,
      patientop: json['patientop'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      self: json['self'] as int,
      faculty: json['faculty'] as int,
    );
  }
  Map<String, dynamic> toJson() => {

    "compentencyevaluationid": compentencyevaluationid,
    "patientop": patientop,
    "date": date,
    "time": time,
    "self": self,
    "faculty": faculty,
  };
}
