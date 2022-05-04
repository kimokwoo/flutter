
import 'dart:convert';

class TeacherModel {
  TeacherModel({
    required this.tId,
    required this.tName,
    required this.schCode,
    required this.schName,
    this.password,
    this.statusNo,
    this.statusName,
    this.college,
    required this.gwamokNo,
    required this.gwamokName,
    this.major,
    this.birth,
    this.yr,
    this.spouse,
    this.tel,
    this.memo,
    this.phototeacher,
    this.retire,
    this.remain,
    required this.teacherHistory,
  });

  final String tId;
  final String tName;
  final String schCode;
  final String schName;
  final String? password;
  final String? statusNo;
  final String? statusName;
  final String? college;
  final String gwamokNo;
  final String gwamokName;
  final String? major;
  final String? birth;
  final String? yr;
  final String? spouse;
  final String? tel;
  final String? memo;
  final String? phototeacher;
  final String? retire;
  final String? remain;
  final List<TeacherHistory> teacherHistory;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
    tId: json["t_id"],
    tName: json["t_name"],
    schCode: json["sch_code"],
    schName: json["sch_name"],
    password: json["password"],
    statusNo: json["status_no"],
    statusName: json["status_name"],
    college: json["college"],
    gwamokNo: json["gwamok_no"],
    gwamokName: json["gwamok_name"],
    major: json["major"],
    birth: json["birth"],
    yr: json["yr"],
    spouse: json["spouse"],
    tel: json["tel"],
    memo: json["memo"],
    phototeacher: json["phototeacher"] ?? '',
    retire: json["retire"],
    remain: json["remain"],
    teacherHistory: List<TeacherHistory>.from(json["teacher_history"].map((x) => TeacherHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "t_id": tId,
    "t_name": tName,
    "sch_code": schCode,
    "sch_name": schName,
    "password": password,
    "status_no": statusNo,
    "status_name": statusName,
    "college": college,
    "gwamok_no": gwamokNo,
    "gwamok_name": gwamokName,
    "major": major,
    "birth": birth,
    "yr": yr,
    "spouse": spouse,
    "tel": tel,
    "memo": memo,
    "phototeacher": phototeacher,
    "retire": retire,
    "remain": remain,
    "teacher_history": List<dynamic>.from(teacherHistory.map((x) => x.toJson())),
  };
}

class TeacherHistory {
  TeacherHistory({
    required this.id,
    required this.tId,
    this.hyear,
    this.schCode,
    this.schName,
    this.depart,
    this.workDetail,
    this.damim,
    this.ban,
  });

  final String id;
  final String tId;
  final String? hyear;
  final String? schCode;
  final String? schName;
  final String? depart;
  final String? workDetail;
  final String? damim;
  final String? ban;

  factory TeacherHistory.fromJson(Map<String, dynamic> json) => TeacherHistory(
    id: json["id"],
    tId: json["t_id"],
    hyear: json["hyear"],
    schCode: json["sch_code"],
    schName: json["sch_name"],
    depart: json["depart"],
    workDetail: json["work_detail"] ?? '',
    damim: json["damim"],
    ban: json["ban"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "t_id": tId,
    "hyear": hyear,
    "sch_code": schCode,
    "sch_name": schName,
    "depart": depart,
    "work_detail": workDetail ,
    "damim": damim,
    "ban": ban ,
  };
}
