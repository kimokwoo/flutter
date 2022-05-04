

class CurrentTimeScheduleModel {
  CurrentTimeScheduleModel({
    required this.ban,
    this.gwamokName1,
    this.teacherName1,
    this.gwamokName2,
    this.teacherName2,
    this.gwamokName3,
    this.teacherName3,
  });

  int ban;
  String? gwamokName1;
  String? teacherName1;
  String? gwamokName2;
  String? teacherName2;
  String? gwamokName3;
  String? teacherName3;

  factory CurrentTimeScheduleModel.fromJson(Map<String, dynamic> json) => CurrentTimeScheduleModel(
    ban: json["ban"] == '' ? '' : json["ban"],
    gwamokName1: json["gwamokName_1"] == '' ? '' : json["gwamokName_1"],
    teacherName1: json["teacherName_1"] == '' ? '' : json["teacherName_1"],
    gwamokName2: json["gwamokName_2"] == '' ? '' : json["gwamokName_2"],
    teacherName2: json["teacherName_2"] == '' ? '' : json["teacherName_2"],
    gwamokName3: json["gwamokName_3"] == '' ? '' : json["gwamokName_3"],
    teacherName3: json["teacherName_3"] == '' ? '' : json["teacherName_3"],
  );

  Map<String, dynamic> toJson() => {
    "ban": ban == null ? null : ban,
    "gwamokName_1": gwamokName1 == null ? null : gwamokName1,
    "teacherName_1": teacherName1 == null ? null : teacherName1,
    "gwamokName_2": gwamokName2 == null ? null : gwamokName2,
    "teacherName_2": teacherName2 == null ? null : teacherName2,
    "gwamokName_3": gwamokName3 == null ? null : gwamokName3,
    "teacherName_3": teacherName3 == null ? null : teacherName3,
  };
}
