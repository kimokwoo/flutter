//공용으로 사용될 클래스를 모아놓은 파일입니다.
import 'dart:convert';

class NoName {
  final int no;
  final String name;
  NoName({required this.no, required this.name});

  factory NoName.fromJson(Map<String, dynamic> json) => NoName(
    no: json["no"],
    name :json["name"],
  );

  Map<String, dynamic> toJson() => {
    "no": no,
    "name": name,
  };
}