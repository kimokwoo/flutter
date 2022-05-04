import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:pjef/models/commonModel.dart';
import 'package:pjef/models/studentBriefModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/timeScheduleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherTimeSchedule extends StatefulWidget {
  const TeacherTimeSchedule({Key? key}) : super(key: key);

  @override
  _TeacherTimeScheduleState createState() => _TeacherTimeScheduleState();
}

class _TeacherTimeScheduleState extends State<TeacherTimeSchedule> {
  List<TimeScheduleModel> timeSchedule = [];
  List<NoName> teacherList = [];
  final teacherTimeScheduleKey = GlobalKey<_TeacherTimeScheduleState>();
  int _teacherNo = 0;
  String _teacherName = '';
  bool _showLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _teacherNo = int.parse(Get.parameters['teacherNo']!);
    _teacherName = Get.parameters['teacherName']!;
    _fetchData();
    //timeSchedule = getTimeSchedule(_teacherNo);
    //getTeacherList();

  }

  Future _fetchData() async {
    setState(() {
      _showLoading = true;
    });
    var url1 = Uri.parse("http://pjef.org/api/get_teacher_timeschedule.php");
    var url2 = Uri.parse("http://pjef.org/api/get_teacher_name_list.php");

    final results = await Future.wait([
      http.post(url1, body: {'teacherNo': _teacherNo.toString()}),
      http.post(url2),
    ]);
    print(jsonDecode(results[0].body));
    print(jsonDecode(results[1].body));

      timeSchedule = jsonDecode(results[0].body).map<TimeScheduleModel>((json) {
        return TimeScheduleModel.fromJson(json);
      }).toList();
      teacherList = jsonDecode(results[1].body).map<NoName>((json) {
        return NoName.fromJson(json);
      }).toList();


    setState(() {
      _showLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    //makeTeacherName(_teacherNo);
    return  Scaffold(
            appBar: AppBar(
              title: const Text('선생님시간표'),
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
              currentIndex: 1,
              //현재 선택된 Index
              onTap: (int index) {
                if (index == 0) {
                  Get.back();
                } else if (index == 2) {
                  Get.offNamed('/currentTimeSchedule');
                }
              },
              items: const [
                BottomNavigationBarItem(
                  label: '반시간표',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: '선생님',
                  icon: Icon(Icons.cast_for_education),
                ),
                BottomNavigationBarItem(
                  label: '현재시간표',
                  icon: Icon(Icons.photo_album),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  if(_showLoading)
                    Center(
                      child: CupertinoActivityIndicator(animating: true,),),
                  if(!_showLoading) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PopupMenuButton<String>(
                          //학년선택
                          onSelected: choiceTeacher,
                          itemBuilder: (BuildContext context) {
                            return teacherList.map((e) {
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
                                _teacherName,
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
                                  '/teacherTimeSchedule/values?teacherNo=$_teacherNo&teacherName=$_teacherName';
                              Get.offNamed(href);
                            },
                            child: const Text("검색"),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: double.infinity,
                        child: DataTable(
                          headingRowHeight: 40.0,
                          horizontalMargin: 10.0,
                          columnSpacing: 5.0,
                          dataRowHeight: 50.0,
                          border: TableBorder.all(),
                          columns: _getColumns(),
                          rows: _getRows(data: timeSchedule),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumns = [
      DataColumn(label: Center(child: Text('교시'))),
      DataColumn(label: Center(child: Text('월요일'))),
      DataColumn(label: Center(child: Text('화요일'))),
      DataColumn(label: Center(child: Text('수요일'))),
      DataColumn(label: Center(child: Text('목요일'))),
      DataColumn(label: Center(child: Text('금요일'))),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<TimeScheduleModel> data}) {
    List<DataRow> dataRow = [];
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        dataRow.add(DataRow(
          cells: [
            DataCell(Center(child: Text(data[i].lectureTime))),
            DataCell(Center(
              child: Text(
                data[i].gwamokName1.toString() + '\n' + data[i].value1.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                data[i].gwamokName1.toString() + '\n' + data[i].value2.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                data[i].gwamokName3.toString() + '\n' + data[i].value3.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                data[i].gwamokName4.toString() + '\n' + data[i].value4.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )),
            DataCell(Center(
              child: Text(
                data[i].gwamokName5.toString() + '\n' + data[i].value5.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            )),
          ],
        ));
      }
    }
    return dataRow;
  }

  void choiceTeacher(String choice) {
    List<NoName> selectList = [];
    selectList = teacherList.where((e) => e.name == choice).toList();
    setState(() {
      _teacherName = selectList[0].name;
      _teacherNo = selectList[0].no;
    });
  }

  void makeTeacherName(int teacherNo) {
    List<NoName> selectList = [];
    selectList = teacherList.where((e) => e.no == teacherNo).toList();
    setState(() {
      _teacherName = selectList[0].name;
    });
  }
}
