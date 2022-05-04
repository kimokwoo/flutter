import 'package:flutter/material.dart';
import 'package:pjef/models/teacherModel.dart';

class TeacherHistoryInfo extends StatefulWidget {
  const TeacherHistoryInfo({Key? key, required this.teacherDetail})
      : super(key: key);
  final TeacherModel teacherDetail;

  @override
  _TeacherHistoryInfoState createState() => _TeacherHistoryInfoState();
}

class _TeacherHistoryInfoState extends State<TeacherHistoryInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.teacherDetail.teacherHistory.length,
        itemBuilder: (context, int index) {
          var history = widget.teacherDetail.teacherHistory;
          String damimTxt = "";
          if (history[index].damim.toString() == '1') {
            damimTxt = "담임 ( ${history[index].ban} )";
          } else {
            damimTxt = "비담임";
          }
          return Card(
            child: ListTile(
              leading: Text(history[index].hyear.toString()),
              title: Text(history[index].schName.toString() +
                  ">" +
                  history[index].depart.toString() +
                  ">" +
                  history[index].workDetail.toString(),
              style: TextStyle(
                fontSize: 15.0,
              ),),
              subtitle: Text(damimTxt,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),),
            ),
          );
        });
  }
}
