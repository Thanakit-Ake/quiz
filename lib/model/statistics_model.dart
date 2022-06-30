// To parse this JSON data, do
//
//     final statistics = statisticsFromJson(jsonString);

import 'dart:convert';

List<Statistics> statisticsFromJson(String str) =>
    List<Statistics>.from(json.decode(str).map((x) => Statistics.fromJson(x)));

String statisticsToJson(List<Statistics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Statistics {
  Statistics({
    required this.point,
    required this.percentage,
    required this.gard,
    required this.date,
    required this.usertimer,
  });

  int point;
  int percentage;
  String gard;
  String date;
  String usertimer;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        point: json["point"],
        percentage: json["percentage"],
        gard: json["gard"],
        date: json["date"],
        usertimer: json["usertimer"],
      );

  Map<String, dynamic> toJson() => {
        "point": point,
        "percentage": percentage,
        "gard": gard,
        "date": date,
        "usertimer": usertimer,
      };
}
