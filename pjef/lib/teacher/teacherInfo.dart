import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:pjef/models/teacherModel.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherInfo extends StatelessWidget {
  //const SchoolScore({Key? key}) : super(key: key);

  final TeacherModel teacherDetail;
  TeacherInfo({required this.teacherDetail});

  @override
  Widget build(BuildContext context) {
    return
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
                        child: Text(teacherDetail.tName),
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
                        child: Text(teacherDetail.schName + " > " + teacherDetail.gwamokName),
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
                        child: Text(teacherDetail.statusName.toString()),
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
                        onTap: () => launch("tel://${teacherDetail.tel.toString()}"),
                        child: Container(
                          child: Text(teacherDetail.tel.toString()),
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
                        child: Text("${teacherDetail.college.toString()} ( ${teacherDetail.major.toString()} )"),
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
                        child: Text("${teacherDetail.retire.toString()} ( ${teacherDetail.remain.toString()} )"),
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
                        child: Text("${teacherDetail.birth}"),
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
                        child: Text("${teacherDetail.yr.toString()} "),
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
                        child: Text("${teacherDetail.memo.toString()} "),
                        height: 50.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //비고
              ],
            ),
        );
  }
}