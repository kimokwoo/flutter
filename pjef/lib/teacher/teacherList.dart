import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/teacherModel.dart';
import 'package:pjef/models/commonModel.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({Key? key}) : super(key: key);

  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  Future<List<TeacherModel>>? teachers;
  final teacherListKey = GlobalKey<_TeacherListState>();
  int _schoolValue = 0;
  int _gwamokValue = 0;
  String _schoolTitle = '전체학교';
  String _gwamokTitle = '전체과목';
  List<NoName> gwamokList = [];
  List<NoName> schoolList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _schoolValue = int.parse(Get.parameters['school']!);
    _gwamokValue = int.parse(Get.parameters['gwamok']!);
    teachers = getTeacherList(_schoolValue, _gwamokValue);

    gwamokList = gwamokMap.entries.map((e) => NoName(no:e.key, name :e.value)).toList();
    schoolList = schoolMap.entries.map((e) => NoName(no:e.key, name :e.value)).toList();

    makeSchoolText(_schoolValue);
    makeGwamokText(_gwamokValue);
  }

  Future<List<TeacherModel>> getTeacherList(
      int? schoolValue, int? gwamokValue) async {
    http.Response response;
    List<TeacherModel> teachers;
    var url = Uri.parse("http://pjef.org/api/get_teacher_list.php");

    response = await http.post(url, body: {
      'school': schoolValue.toString(),
      'gwamok': gwamokValue.toString()
    });
    if (kDebugMode) {
      print(response.body);
    }
    teachers = jsonDecode(response.body).map<TeacherModel>((json) {
      return TeacherModel.fromJson(json);
    }).toList();

    return teachers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('교사명렬'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: 0, //현재 선택된 Index
        onTap: (int index) {
          if (index == 1) {
            Get.toNamed('/teacherSummary/values?syear=2022');
          } else if (index == 2) {
            Get.toNamed('/teacherDamim/values?syear=2022');
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
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PopupMenuButton<String>(
                      //학년선택
                      onSelected: choiceSchool,
                      itemBuilder: (BuildContext context) {
                        return schoolList.map((e) {
                          return PopupMenuItem<String>(
                            child: Text(
                              e.name,
                            ),
                            value: e.name,
                          );
                        }).toList();

                      },
                      child: Row(
                        children: [
                          Text(
                            _schoolTitle,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      //반선택
                      onSelected: choiceGwamok,
                      itemBuilder: (BuildContext context) {
                        return gwamokList.map((e) {
                          return PopupMenuItem<String>(
                            child: Text(
                              e.name,
                            ),
                            value: e.name,
                          );
                        }).toList();

                      },
                      child: Row(
                        children: [
                          Text(
                            _gwamokTitle,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: TextButton(
                        onPressed: () {
                          var href =
                              '/teacherList/value?school=$_schoolValue&gwamok=$_gwamokValue';
                          Get.offAllNamed(href);
                        },
                        child: const Text("검색"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<TeacherModel>>(
                    future: teachers,
                    builder: (BuildContext context, AsyncSnapshot ss) {
                      if (!ss.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ListView.builder(
                          itemCount: ss.data?.length,
                          itemBuilder: (context, int index) {
                            var data = ss.data?[index];
                            return Card(
                              child: ListTile(
                                leading: Text(
                                  data.tName,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                title: Text(
                                  data.schName + " > " + data.gwamokName,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 2.0, bottom: 2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.tel),
                                      Text(
                                          "퇴직 : ${data.retire} ( ${data.remain} )"),
                                      data.teacherHistory.length > 0
                                          ? Text(
                                              "${data.teacherHistory[0].depart}(${data.teacherHistory[0].workDetail})")
                                          : Container(),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                      '/teacherDetail/value?t_id=${data.tId}');
                                },
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }


  void makeSchoolText(int school) {
    List<NoName> selectList = [];
    selectList = schoolList.where((e) => e.no == school).toList();
    setState(() {
      _schoolTitle = selectList[0].name;
    });
  }


  void makeGwamokText(int gwamok) {

    List<NoName> selectList = [];
    selectList = gwamokList.where((e) => e.no == gwamok).toList();
    setState(() {
      _gwamokTitle = selectList[0].name;
    });

  }

  Map gwamokMap = {
    0: '전체과목',
    1: '국어과',
    2: '영어과',
    3: '수학과',
    4: '사회과',
    5: '과학과',
    6: '예체능과',
    7: '생활과',
    8: '기타',
  };

  Map schoolMap = {
    0: '전체학교',
    5: '포항중앙고',
    6: '포항중앙여고',
  };

  void choiceSchool(String choice) {
    List<NoName> selectList = [];
    selectList = schoolList.where((e) => e.name == choice).toList();
    setState(() {
      _schoolValue = selectList[0].no;
      _schoolTitle = selectList[0].name;
    });
  }

  void choiceGwamok(String choice) {
    List<NoName> selectList = [];
    selectList = gwamokList.where((e) => e.name == choice).toList();
    setState(() {
      _gwamokValue = selectList[0].no;
      _gwamokTitle = selectList[0].name;
    });

  }
}


