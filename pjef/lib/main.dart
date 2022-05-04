import 'package:flutter/material.dart';
import 'package:pjef/etcs/coronaList.dart';
import 'package:pjef/login/intro.dart';
import 'package:pjef/login/login.dart';
import 'package:get/get.dart';
import 'package:pjef/student/studentDetail.dart';
import 'package:pjef/student/studentList.dart';
import 'package:pjef/student/studentPhotoList.dart';
import 'package:pjef/student/studentScoreList.dart';
import 'package:pjef/teacher/teacherDamim.dart';
import 'package:pjef/teacher/teacherDetail.dart';
import 'package:pjef/teacher/teacherGwamokList.dart';
import 'package:pjef/teacher/teacherList.dart';
import 'package:pjef/timeSchedule/classTimeSchedule.dart';
import 'package:pjef/timeSchedule/currentTimeSchedule.dart';
import 'package:pjef/timeSchedule/teacherTimeSchedule.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const IntroScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => const LogIn(),
        ),
        GetPage(
          name: '/studentList/:param',
          page: () => const StudentList(),
        ),
        GetPage(
          name: '/studentScoreList/:param',
          page: () => const StudentScoreList(),
        ),
        GetPage(
          name: '/studentPhotoList/:param',
          page: () => const StudentPhotoList(),
        ),
        GetPage(
          name: '/studentDetail/:param',
          page: () => const StudentDetail(),
        ),
        GetPage(
          name: '/teacherList/:param',
          page: () => const TeacherList(),
        ),
        GetPage(
          name: '/teacherSummary/:param',
          page: () => const TeacherGwamokList(),
        ),
        GetPage(
          name: '/teacherDamim/:param',
          page: () => const TeacherDamim(),
        ),
        GetPage(
          name: '/teacherDetail/:param',
          page: () => const TeacherDetail(),
        ),
        GetPage(
          name: '/coronaList/:param',
          page: () => const CoronaList(),
        ),
        GetPage(
          name: '/classTimeSchedule/:param',
          page: () => const ClassTimeSchedule(),
        ),
        GetPage(
          name: '/teacherTimeSchedule/:param',
          page: () => const TeacherTimeSchedule(),
        ),
        GetPage(
          name: '/currentTimeSchedule',
          page: () => const CurrentTimeSchedule(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      title: '포항중앙여고',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroScreen(),
    );
  }
}

