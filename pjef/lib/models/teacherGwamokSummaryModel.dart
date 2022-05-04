

import 'dart:convert';
import 'commonModel.dart';

class TeacherGwamokSummaryModel {
  TeacherGwamokSummaryModel({
    required this.sum1,
    required this.sum2,
    required this.sum3,
    required this.sum4,
    required this.sum5,
    required this.sum6,
    required this.arrTeacher,
  });

  int sum1;
  int sum2;
  int sum3;
  int sum4;
  int sum5;
  int sum6;
  List<TeacherGwamokModel> arrTeacher;

  factory TeacherGwamokSummaryModel.fromJson(Map<String, dynamic> json) => TeacherGwamokSummaryModel(
    sum1: json["sum1"],
    sum2: json["sum2"],
    sum3: json["sum3"],
    sum4: json["sum4"],
    sum5: json["sum5"],
    sum6: json["sum6"],
    arrTeacher: List<TeacherGwamokModel>.from(json["arr_teacher"].map((x) => TeacherGwamokModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sum1": sum1,
    "sum2": sum2,
    "sum3": sum3,
    "sum4": sum4,
    "sum5": sum5,
    "sum6": sum6,
    "arr_teacher": List<dynamic>.from(arrTeacher.map((x) => x.toJson())),
  };


}

class TeacherGwamokModel {
  TeacherGwamokModel({
    required this.gwamokName,
    required this.noManTea1,
    required this.noManTea2,
    required this.noManTea3,
    required this.noWomanTea1,
    required this.noWomanTea2,
    required this.noWomanTea3,
    required this.arrManTea1,
    required this.arrManTea2,
    required this.arrManTea3,
    required this.arrWomanTea1,
    required this.arrWomanTea2,
    required this.arrWomanTea3,
  });

  String gwamokName;
  int noManTea1;
  int noManTea2;
  int noManTea3;
  int noWomanTea1;
  int noWomanTea2;
  int noWomanTea3;
  String? arrManTea1;
  String? arrManTea2;
  String? arrManTea3;
  String? arrWomanTea1;
  String? arrWomanTea2;
  String? arrWomanTea3;

  factory TeacherGwamokModel.fromJson(Map<String, dynamic> json) => TeacherGwamokModel(
    gwamokName: json["gwamok_name"],
    noManTea1: json["noManTea1"],
    noManTea2: json["noManTea2"],
    noManTea3: json["noManTea3"],
    noWomanTea1: json["noWomanTea1"],
    noWomanTea2: json["noWomanTea2"],
    noWomanTea3: json["noWomanTea3"],
    arrManTea1: json["arrManTea1"] ?? '',
    arrManTea2: json["arrManTea2"] ?? '',
    arrManTea3: json["arrManTea3"] ?? '',
    arrWomanTea1: json["arrManTea4"] ?? '',
    arrWomanTea2: json["arrManTea5"] ?? '',
    arrWomanTea3: json["arrManTea6"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "gwamok_name": gwamokName,
    "noManTea1": noManTea1,
    "noManTea2": noManTea2,
    "noManTea3": noManTea3,
    "noWomanTea1": noWomanTea1,
    "noWomanTea2": noWomanTea2,
    "noWomanTea3": noWomanTea3,
    "arrManTea1": arrManTea1,
    "arrManTea2": arrManTea2,
    "arrManTea3": arrManTea3,
    "arrWomanTea1": arrWomanTea1,
    "arrWomanTea2": arrWomanTea2,
    "arrWomanTea3": arrWomanTea3,
  };

}
