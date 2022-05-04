import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/drawers/mainDrawer.dart';
import 'package:pjef/models/currentTimeScheduleModel.dart';
import 'package:pjef/models/studentBriefModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pjef/models/timeScheduleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTimeSchedule extends StatefulWidget {
  const CurrentTimeSchedule({Key? key}) : super(key: key);

  @override
  _CurrentTimeScheduleState createState() => _CurrentTimeScheduleState();
}

class _CurrentTimeScheduleState extends State<CurrentTimeSchedule> {
  Future<List<CurrentTimeScheduleModel>>? timeSchedule;
  final currentTimeScheduleKey = GlobalKey<_CurrentTimeScheduleState>();
  late SharedPreferences _prefs;
  late int _pNo;
  late String _pName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeSchedule = getTimeSchedule();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _pNo = _prefs.getInt('no') ?? 0;
      _pName = _prefs.getString('name') ?? '';
    });
  }

  Future<List<CurrentTimeScheduleModel>> getTimeSchedule() async {
    http.Response response;
    List<CurrentTimeScheduleModel> timeSchedule;
    var url = Uri.parse("http://pjef.org/api/get_current_timeschedule.php");

    response = await http.post(url);
    if (kDebugMode) {
      print(response.body);
    }
    timeSchedule = jsonDecode(response.body).map<CurrentTimeScheduleModel>((json) {
      return CurrentTimeScheduleModel.fromJson(json);
    }).toList();

    return timeSchedule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('현재 시간표'),
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
        currentIndex: 2, //현재 선택된 Index
        onTap: (int index) {
          if (index == 0) {
            Get.back();
          } else if (index == 1) {
            Get.offNamed(
                '/teacherTimeSchedule/values?teacherNo=$_pNo&teacherName=$_pName');
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
            SizedBox(height: 15.0,),
            Expanded(
              child: FutureBuilder<List<CurrentTimeScheduleModel>>(
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
                      columnSpacing: 28.0,
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
      DataColumn(label: Text('반')),
      DataColumn(label: Text('1학년')),
      DataColumn(label: Text('2학년')),
      DataColumn(label: Text('3학년')),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<CurrentTimeScheduleModel> data}) {
    List<DataRow> dataRow = [];
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        dataRow.add(DataRow(
          cells: [
            DataCell(Text(data[i].ban.toString())),
            DataCell(Text(data[i].gwamokName1.toString() + '\n' + data[i].teacherName1.toString())),
            DataCell(Text(data[i].gwamokName2.toString() + '\n' + data[i].teacherName2.toString())),
            DataCell(Text(data[i].gwamokName3.toString() + '\n' + data[i].teacherName3.toString())),
          ],
        ));
      }
    }
    return dataRow;
  }
}
