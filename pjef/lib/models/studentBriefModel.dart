// To parse this JSON data, do
//
//     final studentBriefModel = studentBriefModelFromJson(jsonString);

import 'dart:convert';

class StudentBriefModel {
  StudentBriefModel({
    required this.no,
    required this.name,
    required this.grade,
    required this.ban,
    required this.bunho,
    this.tel,
    this.birthDate,
    this.dinnerOrder,
    this.milkOrder,
    this.oldBan,
    this.oldBunho,
    required this.enterYear,
    this.averageScore,
    this.dream1,
    this.dream2,
    this.photo,
  });

  final String no;
  final String name;
  final String grade;
  final String ban;
  final String bunho;
  final String? tel;
  final String? birthDate;
  final String? dinnerOrder;
  final String? milkOrder;
  final String? oldBan;
  final String? oldBunho;
  final String enterYear;
  final String? averageScore;
  final String? dream1;
  final String? dream2;
  final String? photo;

  factory StudentBriefModel.fromJson(Map<String, dynamic> json) => StudentBriefModel(
    no: json["no"],
    name: json["name"],
    grade: json["grade"],
    ban: json["ban"],
    bunho: json["bunho"],
    tel: json["tel"],
    birthDate: json["birthDate"],
    dinnerOrder: json["dinnerOrder"],
    milkOrder: json["milkOrder"],
    oldBan: json["oldBan"],
    oldBunho: json["oldBunho"],
    enterYear: json["enterYear"],
    averageScore: json["average_score"],
    dream1: json["dream1"],
    dream2: json["dream2"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "name": name,
    "grade": grade,
    "ban": ban,
    "bunho": bunho,
    "tel": tel,
    "birthDate": birthDate,
    "dinnerOrder": dinnerOrder,
    "milkOrder": milkOrder,
    "oldBan": oldBan,
    "oldBunho": oldBunho,
    "enterYear": enterYear,
    "average_score": averageScore,
    "dream1": dream1,
    "dream2": dream2,
    "photo": photo,
  };
}
