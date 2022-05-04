import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageValues {
  static const String Chinese = 'Chinese';
  static const String English = 'English';
  static const String Korean = 'Korean';
  static const String Japanese = 'Japanese';

  static const List<String> languageChoices = <String>[
    Chinese,
    English,
    Korean,
    Japanese,
  ];
}

class CountryValues {
  static const String Korea = '한국';
  static const String Hongkong = '홍콩';
  static const String Singapore = '싱가포르';
  static const String Taipei = '타이페이';
  static const String Bangkok = '방콕';
  static const String Hawaii = '하와이';

  static const List<String> countryChoices = <String>[
    Korea,
    Hongkong,
    Singapore,
    Taipei,
    Bangkok,
    Hawaii,
  ];
}

class GoogleText extends StatelessWidget {
  const GoogleText(
      this.text,{
      this.fontSize,
      this.fontWeight,
      this.color}) : assert(
  text != null,
  '텍스트는 반드시 제공되어야 합니다.',
  );

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        fontSize: fontSize ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? Colors.black,
      ),
    );
  }
}
