import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:pjef/models/studentBriefModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/timeScheduleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassTimeSchedule extends StatefulWidget {
  const ClassTimeSchedule({Key? key}) : super(key: key);

  @override
  _ClassTimeScheduleState createState() => _ClassTimeScheduleState();
}

class _ClassTimeScheduleState extends State<ClassTimeSchedule> {
  Future<List<TimeScheduleModel>>? timeSchedule;
  final classTimeScheduleKey = GlobalKey<_ClassTimeScheduleState>();
  int _banValue = 1;
  int _gradeValue = 1;
  late SharedPreferences _prefs;
  late int _pNo;
  late String _pName;

  final List gradeArray = [1, 2, 3];
  final List banArray = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
    _banValue = int.parse(Get.parameters['ban']!);
    _gradeValue = int.parse(Get.parameters['grade']!);
    timeSchedule = getTimeSchedule(_banValue, _gradeValue);
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _pNo = _prefs.getInt('no') ?? 0;
      _pName = _prefs.getString('name') ?? '';
    });
  }

  Future<List<TimeScheduleModel>> getTimeSchedule(
      int? banValue, int? gradeValue) async {
    http.Response response;
    List<TimeScheduleModel> timeSchedule;
    var url = Uri.parse("http://pjef.org/api/get_class_timeschedule.php");

    response = await http.post(url,
        body: {'grade': gradeValue.toString(), 'ban': banValue.toString()});
    if (kDebugMode) {
      print(response.body);
    }
    timeSchedule = jsonDecode(response.body).map<TimeScheduleModel>((json) {
      return TimeScheduleModel.fromJson(json);
    }).toList();

    return timeSchedule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('반 시간표'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
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
            Get.toNamed('/teacherTimeSchedule/values?teacherNo=$_pNo&teacherName=$_pName');
          } else if (index == 2) {
            Get.toNamed('/currentTimeSchedule');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PopupMenuButton<String>(
                  //학년선택
                  onSelected: (choice) {
                    setState(() {
                      _gradeValue = int.parse(choice);
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return gradeArray.map((e) {
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
                        '${_gradeValue.toString()}학년',
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
                  onSelected: (choice) {
                    setState(() {
                      _banValue = int.parse(choice);
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return banArray.map((e) {
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
                        '${_banValue.toString()}반',
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
                          '/classTimeSchedule/values?grade=$_gradeValue&ban=$_banValue';
                      Get.offNamed(href);
                    },
                    child: const Text("검색"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<TimeScheduleModel>>(
                future: timeSchedule,
                builder: (BuildContext context, AsyncSnapshot ss) {
                  if (!ss.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    child: DataTable(
                      headingRowHeight: 40.0,
                      horizontalMargin: 10.0,
                      columnSpacing: 5.0,
                      dataRowHeight: 50.0,
                      border: TableBorder.all(),
                      columns: _getColumns(),
                      rows: _getRows(data: ss.data),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumns = [
      DataColumn(label: Text('교시')),
      DataColumn(label: Text('월요일')),
      DataColumn(label: Text('화요일')),
      DataColumn(label: Text('수요일')),
      DataColumn(label: Text('목요일')),
      DataColumn(label: Text('금요일')),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<TimeScheduleModel> data}) {
    List<DataRow> dataRow = [];
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        dataRow.add(DataRow(
          cells: [
            DataCell(Text(data[i].lectureTime)),
            DataCell(Text(
              data[i].gwamokName1.toString() + '\n' + data[i].value1.toString(),
              style: TextStyle(
                fontSize: 13.0,
              ),
            )),
            DataCell(Text(
              data[i].gwamokName2.toString() + '\n' + data[i].value2.toString(),
              style: TextStyle(
                fontSize: 13.0,
              ),
            )),
            DataCell(Text(
              data[i].gwamokName3.toString() + '\n' + data[i].value3.toString(),
              style: TextStyle(
                fontSize: 13.0,
              ),
            )),
            DataCell(Text(
              data[i].gwamokName4.toString() + '\n' + data[i].value4.toString(),
              style: TextStyle(
                fontSize: 13.0,
              ),
            )),
            DataCell(Text(
              data[i].gwamokName5.toString() + '\n' + data[i].value5.toString(),
              style: TextStyle(
                fontSize: 13.0,
              ),
            )),
          ],
        ));
      }
    }
    return dataRow;
  }
}
