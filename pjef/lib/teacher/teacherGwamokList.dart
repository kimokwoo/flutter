import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/teacherGwamokSummaryModel.dart';
import 'package:pjef/models/teacherModel.dart';
import 'package:pjef/models/commonModel.dart';

class TeacherGwamokList extends StatefulWidget {
  const TeacherGwamokList({Key? key}) : super(key: key);

  @override
  _TeacherGwamokListState createState() => _TeacherGwamokListState();
}

class _TeacherGwamokListState extends State<TeacherGwamokList> {
  late Future<TeacherGwamokSummaryModel> teacherGwamok;
  final teacherGwamokListKey = GlobalKey<_TeacherGwamokListState>();
  int _yearValue = DateTime.now().year;
  List<int> _yearList = [
    2021,
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
    2029,
    2030
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yearValue = int.parse(Get.parameters['syear']!);
    teacherGwamok = getTeacherGwamokList(_yearValue);
  }

  Future<TeacherGwamokSummaryModel> getTeacherGwamokList(int yearValue) async {
    http.Response response;
    TeacherGwamokSummaryModel teacherGwamok;
    var url = Uri.parse("http://pjef.org/api/get_gwamok_summary1.php");

    response = await http.post(url, body: {'syear': yearValue.toString()});
    if (kDebugMode) {
      print(response.body);
    }
    teacherGwamok =
        TeacherGwamokSummaryModel.fromJson(jsonDecode(response.body));

    return teacherGwamok;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과원 현황'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: 1, //현재 선택된 Index
        onTap: (int index) {
          if (index == 0) {
            Get.toNamed('/teacherList/values?school=0&gwamok=0');
          } else if (index == 2) {
            Get.offNamed('/teacherDamim/values?syear=2022');
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: '교사명렬',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: '교원현황',
            icon: Icon(Icons.cast_for_education),
          ),
          BottomNavigationBarItem(
            label: '담임교사',
            icon: Icon(Icons.photo_album),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<TeacherGwamokSummaryModel>(
            future: teacherGwamok,
            builder: (BuildContext context, AsyncSnapshot ss) {
              if (!ss.hasData) {
                //print(ss);
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: <Widget>[
                  Container(
                    color: Colors.orange,
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "포항중앙고 : ${ss.data.sum1} / ${ss.data.sum2} / ${ss.data.sum3}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            Text(
                              "포항중앙여고 : ${ss.data.sum4} / ${ss.data.sum5} / ${ss.data.sum6}",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          //년도선택
                          onSelected: choiceYear,
                          itemBuilder: (BuildContext context) {
                            return _yearList.map((e) {
                              return PopupMenuItem<String>(
                                child: Text(
                                  e.toString(),
                                ),
                                value: e.toString(),
                              );
                            }).toList();
                          },

                          child: Row(
                            children: [
                              Text(
                                _yearValue.toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: ss.data.arrTeacher?.length,
                        itemBuilder: (context, int index) {
                          var data = ss.data.arrTeacher?[index];
                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    data.gwamokName,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.0),
                                ),
                                ListTile(
                                  leading: SizedBox(
                                    width: 60.0,
                                    child: Text(
                                      "중앙고",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "교사(${data.noManTea1}명) : ${data.arrManTea1}"),
                                        Text(
                                            "기간제(${data.noManTea2}명) : ${data.arrManTea2}"),
                                        Text(
                                            "퇴직(${data.noManTea3}명) : ${data.arrManTea3}"),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: SizedBox(
                                    width: 60.0,
                                    child: Text(
                                      "중앙여고",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "교사(${data.noWomanTea1}명) : ${data.arrWomanTea1}"),
                                        Text(
                                            "기간제(${data.noWomanTea2}명) : ${data.arrWomanTea2}"),
                                        Text(
                                            "퇴직(${data.noWomanTea3}명) : ${data.arrWomanTea3}"),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void choiceYear(String choice) {
    Get.offNamed('/teacherSummary/values?syear=$choice');
  }
}
