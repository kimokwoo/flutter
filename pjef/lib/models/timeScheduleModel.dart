// To parse this JSON data, do
//
//     final timeScheduleModel = timeScheduleModelFromJson(jsonString);

class TimeScheduleModel {
  TimeScheduleModel({
    required this.lectureTime,
    this.gwamokName1,
    this.value1,
    this.gwamok1,
    this.teacher1,
    this.gwamokName2,
    this.value2,
    this.gwamok2,
    this.teacher2,
    this.gwamokName3,
    this.value3,
    this.gwamok3,
    this.teacher3,
    this.gwamokName4,
    this.value4,
    this.gwamok4,
    this.teacher4,
    this.gwamokName5,
    this.value5,
    this.gwamok5,
    this.teacher5,
  });

  String lectureTime;
  String? gwamokName1;
  String? value1;
  String? gwamok1;
  String? teacher1;
  String? gwamokName2;
  String? value2;
  String? gwamok2;
  String? teacher2;
  String? gwamokName3;
  String? value3;
  String? gwamok3;
  String? teacher3;
  String? gwamokName4;
  String? value4;
  String? gwamok4;
  String? teacher4;
  String? gwamokName5;
  String? value5;
  String? gwamok5;
  String? teacher5;

  factory TimeScheduleModel.fromJson(Map<String, dynamic> json) => TimeScheduleModel(
    lectureTime: json["lectureTime"] ,
    gwamokName1: json["gwamokName_1"] == null ? '' : json["gwamokName_1"],
    value1: json["value_1"] == null ? '' : json["value_1"],
    gwamok1: json["gwamok_1"] == null ? '' : json["gwamok_1"],
    teacher1: json["teacher_1"] == null ? '' : json["teacher_1"],
    gwamokName2: json["gwamokName_2"] == null ? '' : json["gwamokName_2"],
    value2: json["value_2"] == null ? '' : json["value_2"],
    gwamok2: json["gwamok_2"] == null ? '' : json["gwamok_2"],
    teacher2: json["teacher_2"] == null ? '' : json["teacher_2"],
    gwamokName3: json["gwamokName_3"] == null ? '' : json["gwamokName_3"],
    value3: json["value_3"] == null ? '' : json["value_3"],
    gwamok3: json["gwamok_3"] == null ? '' : json["gwamok_3"],
    teacher3: json["teacher_3"] == null ? '' : json["teacher_3"],
    gwamokName4: json["gwamokName_4"] == null ? '' : json["gwamokName_4"],
    value4: json["value_4"] == null ? '' : json["value_4"],
    gwamok4: json["gwamok_4"] == null ? '' : json["gwamok_4"],
    teacher4: json["teacher_4"] == null ? '' : json["teacher_4"],
    gwamokName5: json["gwamokName_5"] == null ? '' : json["gwamokName_5"],
    value5: json["value_5"] == null ? '' : json["value_5"],
    gwamok5: json["gwamok_5"] == null ? '' : json["gwamok_5"],
    teacher5: json["teacher_5"] == null ? '' : json["teacher_5"],
  );

  Map<String, dynamic> toJson() => {
    "lectureTime": lectureTime == null ? null : lectureTime,
    "gwamokName_1": gwamokName1 == null ? null : gwamokName1,
    "value_1": value1 == null ? null : value1,
    "gwamok_1": gwamok1 == null ? null : gwamok1,
    "teacher_1": teacher1 == null ? null : teacher1,
    "gwamokName_2": gwamokName2 == null ? null : gwamokName2,
    "value_2": value2 == null ? null : value2,
    "gwamok_2": gwamok2 == null ? null : gwamok2,
    "teacher_2": teacher2 == null ? null : teacher2,
    "gwamokName_3": gwamokName3 == null ? null : gwamokName3,
    "value_3": value3 == null ? null : value3,
    "gwamok_3": gwamok3 == null ? null : gwamok3,
    "teacher_3": teacher3 == null ? null : teacher3,
    "gwamokName_4": gwamokName4 == null ? null : gwamokName4,
    "value_4": value4 == null ? null : value4,
    "gwamok_4": gwamok4 == null ? null : gwamok4,
    "teacher_4": teacher4 == null ? null : teacher4,
    "gwamokName_5": gwamokName5 == null ? null : gwamokName5,
    "value_5": value5 == null ? null : value5,
    "gwamok_5": gwamok5 == null ? null : gwamok5,
    "teacher_5": teacher5 == null ? null : teacher5,
  };
}
