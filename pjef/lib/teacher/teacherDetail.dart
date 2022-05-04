import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pjef/models/teacherModel.dart';
import 'package:pjef/student/studentInfo.dart';
import 'package:pjef/student/studentMTestScore.dart';
import 'package:pjef/student/studentScore.dart';
import 'package:pjef/teacher/teacherHistoryInfo.dart';
import 'package:pjef/teacher/teacherInfo.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherDetail extends StatefulWidget {
  const TeacherDetail({Key? key}) : super(key: key);

  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail>
    with SingleTickerProviderStateMixin {
  late Future<TeacherModel> teacherDetail;
  final teacherDetailKey = GlobalKey<_TeacherDetailState>();
  int _selectedNo = 0;

  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedNo = int.parse(Get.parameters['t_id']!);
    teacherDetail = getTeacherDetail(_selectedNo);

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  Future<TeacherModel> getTeacherDetail(int selectNo) async {
    http.Response response;
    TeacherModel teacherDetail;
    var url = Uri.parse("http://pjef.org/api/get_teacher_detail.php");

    response = await http.post(url, body: {'t_id': selectNo.toString()});
    print(jsonDecode(response.body));
    teacherDetail = TeacherModel.fromJson(jsonDecode(response.body));

    return teacherDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TeacherModel>(
        future: teacherDetail,
        builder: (BuildContext context, AsyncSnapshot ss) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('교사 상세 정보'),
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(
                    text: "기본",
                  ),
                  Tab(text: "경력"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  //margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.only(left: 20.0,right: 20.0, top: 10.0),
                  child: Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {0: FixedColumnWidth(80.0), 1: FlexColumnWidth()},
                    children: <TableRow>[
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("이름"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(ss.data.tName),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //이름
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("소속"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(ss.data.schName + " > " + ss.data.gwamokName),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //소속
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("구분"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text(ss.data.statusName.toString()),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //상태
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("전화번호"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: GestureDetector(
                              onTap: () => launch("tel://${ss.data.tel.toString()}"),
                              child: Container(
                                child: Text(ss.data.tel.toString()),
                                height: 32.0,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ),
                        ],
                      ), //전화번호
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("대학"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text("${ss.data.college.toString()} ( ${ss.data.major.toString()} )"),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //대학
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("예상퇴직"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text("${ss.data.retire.toString()} ( ${ss.data.remain.toString()} )"),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //예상퇴직
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("생년월일"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text("${ss.data.birth}"),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //생년월일
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("채용연도"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text("${ss.data.yr.toString()} "),
                              height: 32.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //채용연도
                      TableRow(
                        children: <TableCell>[
                          TableCell(
                            child: Container(
                              child: Text("비고"),
                              height: 32.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          TableCell(
                            child: Container(
                              child: Text("${ss.data.memo.toString()} "),
                              height: 50.0,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ), //비고
                    ],
                  ),
                ),
                TeacherHistoryInfo(teacherDetail: ss.data),
              ],
            ),
          );
        });
  }
}
