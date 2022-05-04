
import 'dart:convert';

class CoronaInfoModel {
  CoronaInfoModel({
    required this.remark,
    required this.coronaInfo,
  });

  final String remark;
  final List<CoronaDetailModel> coronaInfo;

  factory CoronaInfoModel.fromJson(Map<String, dynamic> json) => CoronaInfoModel(
    remark: json["remark"],
    coronaInfo: List<CoronaDetailModel>.from(json["corona_info"].map((x) => CoronaDetailModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "corona_info": List<dynamic>.from(coronaInfo.map((x) => x.toJson())),
  };
}

class CoronaDetailModel {
  CoronaDetailModel({
    required this.no,
    required this.gubun,
    required this.name,
    required this.banbunho,
    required this.status,
    required this.tel,
    required this.fromdate,
    required this.enddate,
  });

  final String no;
  final String gubun;
  final String name;
  final String banbunho;
  final String status;
  final String tel;
  final String fromdate;
  final String enddate;

  factory CoronaDetailModel.fromJson(Map<String, dynamic> json) => CoronaDetailModel(
    no: json["no"],
    gubun: json["gubun"],
    name: json["name"],
    banbunho: json["banbunho"],
    status: json["status"],
    tel: json["tel"],
    fromdate: json["fromdate"],
    enddate: json["enddate"],
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "gubun": gubun,
    "name": name,
    "banbunho": banbunho,
    "status": status,
    "tel": tel,
    "fromdate": fromdate,
    "enddate": enddate,
  };
}
