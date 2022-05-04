// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

List<StudentModel> studentFromJson(String str) =>
    List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentToJson(List<StudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    required this.no,
    this.studentId,
    required this.name,
    required this.grade,
    required this.ban,
    required this.bunho,
    this.tel,
    this.birthDate,
    this.dinnerOrder,
    this.milkOrder,
    required this.enterYear,
    this.averageScore,
    this.dream1,
    this.dream2,
    this.address,
    this.zipCode,
    this.middleSchool,
    this.middleScore,
    this.fatherName,
    this.fatherTel,
    this.motherName,
    this.motherTel,
    this.photo,
    this.koreanScore,
    this.mathScore,
    this.englishScore,
    this.socialScore,
    this.scienceScore,
    required this.schoolScore,
    required this.mTestScore,
    required this.studentMemo,
  });

  final String no;
  final String? studentId;
  final String name;
  final String grade;
  final String ban;
  final String bunho;
  final String? tel;
  final String? birthDate;
  final String? dinnerOrder;
  final String? milkOrder;
  final String enterYear;
  final String? averageScore;
  final String? dream1;
  final String? dream2;
  final String? address;
  final String? zipCode;
  final String? middleSchool;
  final String? middleScore;
  final String? fatherName;
  final String? fatherTel;
  final String? motherName;
  final String? motherTel;
  final String? photo;
  final String? koreanScore;
  final String? mathScore;
  final String? englishScore;
  final String? socialScore;
  final String? scienceScore;
  final SchoolScore schoolScore;
  final List<MTestScore> mTestScore;
  final List<StudentMemo> studentMemo;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        no: json["no"],
        studentId: json["studentId"],
        name: json["name"],
        grade: json["grade"],
        ban: json["ban"],
        bunho: json["bunho"],
        tel: json["tel"],
        birthDate: json["birthDate"],
        dinnerOrder: json["dinnerOrder"],
        milkOrder: json["milkOrder"],
        enterYear: json["enterYear"],
        averageScore: json["average_score"],
        dream1: json["dream1"] ?? '',
        dream2: json["dream2"] ?? '',
        address: json["address"],
        zipCode: json["zipCode"],
        middleSchool: json["middleSchool"],
        middleScore: json["middleScore"],
        fatherName: json["fatherName"],
        fatherTel: json["fatherTel"],
        motherName: json["motherName"],
        motherTel: json["motherTel"],
        photo: json["photo"],
        koreanScore: json["koreanScore"],
        mathScore: json["mathScore"],
        englishScore: json["englishScore"],
        socialScore: json["socialScore"],
        scienceScore: json["scienceScore"],
        schoolScore: SchoolScore.fromJson(json["schoolScore"]),
        mTestScore: List<MTestScore>.from(
            json["mTestScore"].map((x) => MTestScore.fromJson(x))),
        studentMemo: List<StudentMemo>.from(json["studentMemo"].map((x) => StudentMemo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "studentId": studentId,
        "name": name,
        "grade": grade,
        "ban": ban,
        "bunho": bunho,
        "tel": tel,
        "birthDate": birthDate,
        "dinnerOrder": dinnerOrder,
        "milkOrder": milkOrder,
        "enterYear": enterYear,
        "average_score": averageScore,
        "dream1": dream1,
        "dream2": dream2,
        "address": address,
        "zipCode": zipCode,
        "middleSchool": middleSchool,
        "middleScore": middleScore,
        "fatherName": fatherName,
        "fatherTel": fatherTel,
        "motherName": motherName,
        "motherTel": motherTel,
        "photo": photo,
        "koreanScore": koreanScore,
        "mathScore": mathScore,
        "englishScore": englishScore,
        "socialScore": socialScore,
        "scienceScore": scienceScore,
        "schoolScore": schoolScore.toJson(),
        "mTestScore": List<MTestScore>.from(mTestScore.map((x) => x.toJson())),
        "studentMemo": List<StudentMemo>.from(studentMemo.map((x) => x.toJson())),
      };
}

class MTestScore {
  MTestScore({
    required this.tYear,
    required this.tMonth,
    this.koreanStdScore,
    this.koreanPercent,
    this.koreanRank,
    this.mathStdScore,
    this.mathPercent,
    this.mathRank,
    this.engScore,
    this.engRank,
    this.historyScore,
    this.historyRank,
    this.tam1Gwamok,
    this.tam1StdScore,
    this.tam1Percent,
    this.tam1Rank,
    this.tam2Gwamok,
    this.tam2StdScore,
    this.tam2Percent,
    this.tam2Rank,
  });

  final String tYear;
  final String tMonth;
  final String? koreanStdScore;
  final String? koreanPercent;
  final String? koreanRank;
  final String? mathStdScore;
  final String? mathPercent;
  final String? mathRank;
  final String? engScore;
  final String? engRank;
  final String? historyScore;
  final String? historyRank;
  final String? tam1Gwamok;
  final String? tam1StdScore;
  final String? tam1Percent;
  final String? tam1Rank;
  final String? tam2Gwamok;
  final String? tam2StdScore;
  final String? tam2Percent;
  final String? tam2Rank;

  factory MTestScore.fromJson(Map<String, dynamic> json) => MTestScore(
        tYear: json["tYear"],
        tMonth: json["tMonth"],
        koreanStdScore: json["korean_std_score"],
        koreanPercent: json["korean_percent"],
        koreanRank: json["korean_rank"],
        mathStdScore: json["math_std_score"],
        mathPercent: json["math_percent"],
        mathRank: json["math_rank"],
        engScore: json["eng_score"],
        engRank: json["eng_rank"],
        historyScore: json["history_score"],
        historyRank: json["history_rank"],
        tam1Gwamok: json["tam1_gwamok"],
        tam1StdScore: json["tam1_std_score"],
        tam1Percent: json["tam1_percent"],
        tam1Rank: json["tam1_rank"],
        tam2Gwamok: json["tam2_gwamok"],
        tam2StdScore: json["tam2_std_score"],
        tam2Percent: json["tam2_percent"],
        tam2Rank: json["tam2_rank"],
      );

  Map<String, dynamic> toJson() => {
        "tYear": tYear,
        "tMonth": tMonth,
        "korean_std_score": koreanStdScore,
        "korean_percent": koreanPercent,
        "korean_rank": koreanRank,
        "math_std_score": mathStdScore,
        "math_percent": mathPercent,
        "math_rank": mathRank,
        "eng_score": engScore,
        "eng_rank": engRank,
        "history_score": historyScore,
        "history_rank": historyRank,
        "tam1_gwamok": tam1Gwamok,
        "tam1_std_score": tam1StdScore,
        "tam1_percent": tam1Percent,
        "tam1_rank": tam1Rank,
        "tam2_gwamok": tam2Gwamok,
        "tam2_std_score": tam2StdScore,
        "tam2_percent": tam2Percent,
        "tam2_rank": tam2Rank,
      };
}

class SchoolScore {
  SchoolScore({
    this.scoreAverage11,
    this.scoreAverage12,
    this.scoreAverage21,
    this.scoreAverage22,
    this.scoreAverage31,
    this.scoreAverage32,
    required this.score11,
    required this.score12,
    required this.score21,
    required this.score22,
    required this.score31,
    required this.score32,
  });

  final String? scoreAverage11;
  final String? scoreAverage12;
  final String? scoreAverage21;
  final String? scoreAverage22;
  final String? scoreAverage31;
  final String? scoreAverage32;
  List<Score> score11;
  List<Score> score12;
  List<Score> score21;
  List<Score> score22;
  List<Score> score31;
  List<Score> score32;

  factory SchoolScore.fromJson(Map<String, dynamic> json) => SchoolScore(
        scoreAverage11: json["scoreAverage11"],
        scoreAverage12: json["scoreAverage12"],
        scoreAverage21: json["scoreAverage21"],
        scoreAverage22: json["scoreAverage22"],
        scoreAverage31: json["scoreAverage31"],
        scoreAverage32: json["scoreAverage32"],
        score11:
            List<Score>.from(json["score11"].map((x) => Score.fromJson(x))),
        score12:
            List<Score>.from(json["score12"].map((x) => Score.fromJson(x))),
        score21:
            List<Score>.from(json["score21"].map((x) => Score.fromJson(x))),
        score22:
            List<Score>.from(json["score22"].map((x) => Score.fromJson(x))),
        score31:
            List<Score>.from(json["score31"].map((x) => Score.fromJson(x))),
        score32:
            List<Score>.from(json["score32"].map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "scoreAverage11": scoreAverage11,
        "scoreAverage12": scoreAverage12,
        "scoreAverage21": scoreAverage21,
        "scoreAverage22": scoreAverage22,
        "scoreAverage31": scoreAverage31,
        "scoreAverage32": scoreAverage32,
        "score11": List<dynamic>.from(score11.map((x) => x.toJson())),
        "score12": List<dynamic>.from(score12.map((x) => x.toJson())),
        "score21": List<dynamic>.from(score21.map((x) => x)),
        "score22": List<dynamic>.from(score22.map((x) => x)),
        "score31": List<dynamic>.from(score31.map((x) => x)),
        "score32": List<dynamic>.from(score32.map((x) => x)),
      };
}

class Score {
  Score({
    this.grade,
    this.semester,
    this.gwamokName,
    this.unitNo,
    this.scoreRank,
    this.scoreAbc,
  });

  final String? grade;
  final String? semester;
  final String? gwamokName;
  final String? unitNo;
  final String? scoreRank;
  final String? scoreAbc;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        grade: json["grade"],
        semester: json["semester"],
        gwamokName: json["gwamok_name"],
        unitNo: json["unit_no"],
        scoreRank: json["score_rank"],
        scoreAbc: json["score_abc"],
      );

  Map<String, dynamic> toJson() => {
        "grade": grade,
        "semester": semester,
        "gwamok_name": gwamokName,
        "unit_no": unitNo,
        "score_rank": scoreRank,
        "score_abc": scoreAbc,
      };
}

class StudentMemo {
  StudentMemo({
    this.no,
    this.contents,
    this.categoryNo,
    this.category_name,
    this.type,
    this.teacherNo,
    this.teacher_name,
    this.reg_date,
    this.is_show,
  });

  final String? no;
  final String? contents;
  final String? categoryNo;
  final String? category_name;
  final String? type;
  final String? teacherNo;
  final String? teacher_name;
  final String? reg_date;
  final String? is_show;

  factory StudentMemo.fromJson(Map<String, dynamic> json) => StudentMemo(
        no: json["no"],
        contents: json["contents"],
        categoryNo: json["categoryNo"],
        category_name: json["category_name"],
        type: json["type"],
        teacherNo: json["teacherNo"],
        teacher_name: json["teacher_name"],
        reg_date: json["reg_date"],
        is_show: json["is_show"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "contents": contents,
        "categoryNo": categoryNo,
        "category_name": category_name,
        "type": type,
        "teacherNo": teacherNo,
        "teacher_name": teacher_name,
        "reg_date": reg_date,
        "is_show": is_show,
      };
}
