// To parse this JSON data, do
//
//     final selectModel = selectModelFromJson(jsonString);

import 'dart:convert';

List<SelectModel> selectModelFromJson(String str) => List<SelectModel>.from(
    json.decode(str).map((x) => SelectModel.fromJson(x)));

String selectModelToJson(List<SelectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectModel {
  SelectModel({
    required this.title,
    required this.subtitle,
    required this.img,
  });

  String title;
  String subtitle;
  String img;

  factory SelectModel.fromJson(Map<String, dynamic> json) => SelectModel(
        title: json["title"],
        subtitle: json["subtitle"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "img": img,
      };
}
