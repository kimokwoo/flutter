import 'dart:convert';

class TeacherDamimModel {
  TeacherDamimModel({
    required this.ban,
    required this.teacher1,
    required this.teacher2,
    required this.teacher3,
  });

  final int ban;
  final String teacher1;
  final String teacher2;
  final String teacher3;

  factory TeacherDamimModel.fromJson(Map<String, dynamic> json) => TeacherDamimModel(
    ban: json["ban"],
    teacher1: json["teacher1"],
    teacher2: json["teacher2"],
    teacher3: json["teacher3"],
  );

  Map<String, dynamic> toJson() => {
    "ban": ban,
    "teacher1": teacher1,
    "teacher2": teacher2,
    "teacher3": teacher3,
  };
}