import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentInfo extends StatelessWidget {
  //const SchoolScore({Key? key}) : super(key: key);

  final StudentModel studentDetail;
  StudentInfo({required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    //title: new Text("사진"),
                    content: Image(
                      image: NetworkImage("http://pjef.org/student/pict/" +
                          studentDetail.photo.toString()),
                      width: 350.0,
                    ),
                    actions: <Widget>[
                      new TextButton(
                        child: new Text("닫기"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
                child: Image(
                  image: NetworkImage("http://pjef.org/student/pict/" +
                      studentDetail.photo.toString()),
                  width: 150.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                //margin: EdgeInsets.all(10.0),
                padding: const EdgeInsets.only(right: 20.0, top: 30.0),
                child: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {0: FixedColumnWidth(60.0), 1: FlexColumnWidth()},
                  children: <TableRow>[
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("학생이름"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.name),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //학생이름
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("학생 ID"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.studentId.toString()),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //학생ID
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("반/번호"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(
                                "${studentDetail.grade} / ${studentDetail.ban} / ${studentDetail.bunho}"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //반번호
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("전화"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.tel.toString()),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //전화
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("생년월일"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.birthDate.toString()),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //생년월일
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("입학년도"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.enterYear.toString()),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //입학년도
                    TableRow(
                      children: <TableCell>[
                        TableCell(
                          child: Container(
                            child: Text("평균등급"),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                        TableCell(
                          child: Container(
                            child: Text(studentDetail.averageScore.toString()),
                            height: 30.0,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ), //평균등급
                  ],
                ),
              ),
            ),
          ],
        ),
        //SizedBox(height: 20.0,),
        Expanded(
          child: Container(
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
                        child: Text("진로(1학년)"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Text(studentDetail.dream1.toString()),
                        height: 32.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //진로1
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Container(
                        child: Text("진로(2학년)"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Text(studentDetail.dream2.toString()),
                        height: 32.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //진로2
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Container(
                        child: Text("중학교"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Text("${studentDetail.middleSchool.toString()} ( ${studentDetail.middleScore.toString()} )"),
                        height: 32.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //중학교
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Container(
                        child: Text("아버지"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: GestureDetector(
                        onTap: () => launch("tel://${studentDetail.fatherTel.toString()}"),
                        child: Container(
                          child: Text("${studentDetail.fatherName.toString()} ( ${studentDetail.fatherTel.toString()} )"),
                          height: 32.0,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                  ],
                ), //아버지
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Container(
                        child: Text("어머니"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Text("${studentDetail.motherName.toString()} ( ${studentDetail.motherTel.toString()} )"),
                        height: 32.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //어머니
                TableRow(
                  children: <TableCell>[
                    TableCell(
                      child: Container(
                        child: Text("주소"),
                        height: 32.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Text(studentDetail.address.toString()),
                        height: 50.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ), //주소
              ],
            ),
          ),
        ),
      ],
    );
  }
}