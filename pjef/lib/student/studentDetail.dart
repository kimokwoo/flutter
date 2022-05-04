import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pjef/student/studentInfo.dart';
import 'package:pjef/student/studentMTestScore.dart';
import 'package:pjef/student/studentScore.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail>
    with SingleTickerProviderStateMixin {
  Future<StudentModel>? studentDetail;
  final studentDetailKey = GlobalKey<_StudentDetailState>();
  int _selectedNo = 0;
  int _tabIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedNo = int.parse(Get.parameters['no']!);
    studentDetail = getStudentDetail(_selectedNo);

    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  Future<StudentModel> getStudentDetail(int selectNo) async {
    http.Response response;
    StudentModel studentDetail;
    var url = Uri.parse("http://pjef.org/api/get_student_detail5.php");

    response = await http.post(url, body: {'no': selectNo.toString()});
    print(jsonDecode(response.body));
    studentDetail = StudentModel.fromJson(jsonDecode(response.body));

    return studentDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentModel>(
        future: studentDetail,
        builder: (BuildContext context, AsyncSnapshot ss) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('학생 상세 정보'),
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: "기본",
                  ),
                  Tab(text: "내신"),
                  Tab(text: "모의고사"),
                  Tab(text: "누가기록"),
                  Tab(text: "입시"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                StudentInfo(studentDetail: ss.data!),
                StudentScore(studentDetail: ss.data!),
                StudentMTestScore(studentDetail: ss.data!),
                const Center(
                  child: Text(
                    '작업 중 입니다.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    '작업 중 입니다.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
