// To parse this JSON data, do
//
//     final qusetionModel = qusetionModelFromJson(jsonString);

import 'dart:convert';

List<QusetionModel> qusetionModelFromJson(String str) =>
    List<QusetionModel>.from(
        json.decode(str).map((x) => QusetionModel.fromJson(x)));

String qusetionModelToJson(List<QusetionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QusetionModel {
  QusetionModel({
    required this.title,
    required this.img,
    required this.choices,
    required this.anserId,
  });

  String title;
  String img;
  List<Choice> choices;
  int anserId;

  factory QusetionModel.fromJson(Map<String, dynamic> json) => QusetionModel(
        title: json["title"],
        img: json["img"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        anserId: json["anserID"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "img": img,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "anserID": anserId,
      };
}

class Choice {
  Choice({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
