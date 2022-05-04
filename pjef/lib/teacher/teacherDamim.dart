import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pjef/models/teacherDamimModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TeacherDamim extends StatefulWidget {
  const TeacherDamim({Key? key}) : super(key: key);

  @override
  _TeacherDamimState createState() => _TeacherDamimState();
}

class _TeacherDamimState extends State<TeacherDamim> {
  late Future<List<TeacherDamimModel>> teacherDamim;
  final teacherDamimKey = GlobalKey<_TeacherDamimState>();
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
    teacherDamim = getTeacherDamimList(_yearValue);
  }

  Future<List<TeacherDamimModel>> getTeacherDamimList(int yearValue) async {
    http.Response response;
    List<TeacherDamimModel> teacherDamim;
    var url = Uri.parse("http://pjef.org/api/get_damim_teacher1.php");

    response = await http.post(url, body: {'syear': yearValue.toString()});
    if (kDebugMode) {
      print(response.body);
    }
    teacherDamim = jsonDecode(response.body).map<TeacherDamimModel>((json) {
      return TeacherDamimModel.fromJson(json);
    }).toList();

    return teacherDamim;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TeacherDamimModel>>(
        future: teacherDamim,
        builder: (BuildContext context, AsyncSnapshot ss) {
          if (!ss.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('담임교사'),
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              actions: <Widget>[
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
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.grey,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: 2, //현재 선택된 Index
              onTap: (int index) {
                if (index == 0) {
                  Get.back();
                } else if (index == 1) {
                  Get.offNamed('/teacherSummary/values?syear=2022');
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
            body: Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              child: DataTable(
                headingRowHeight: 40.0,
                horizontalMargin: 10.0,
                columnSpacing: 28.0,
                dataRowHeight: 30.0,
                border: TableBorder.all(),
                columns: _getColumns(),
                rows: _getRows(data: ss.data),
              ),
            ),
          );
        });
  }

  void choiceYear(String choice) {
    Get.offNamed('/teacherDamim/values?syear=$choice');
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumns = [
      DataColumn(label: Text('반')),
      DataColumn(label: Text('1학년')),
      DataColumn(label: Text('2학년')),
      DataColumn(label: Text('3학년')),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<TeacherDamimModel> data}) {
    List<DataRow> dataRow = [];
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        dataRow.add(DataRow(
          cells: [
            DataCell(Text(data[i].ban.toString())),
            DataCell(Text(data[i].teacher1)),
            DataCell(Text(data[i].teacher2)),
            DataCell(Text(data[i].teacher3)),
          ],
        ));
      }
    }
    return dataRow;
  }
}
