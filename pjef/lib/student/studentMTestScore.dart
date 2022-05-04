import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentMTestScore extends StatefulWidget {
  final StudentModel studentDetail;

  StudentMTestScore({Key? key, required this.studentDetail}) : super(key: key);

  @override
  State<StudentMTestScore> createState() => _StudentMTestScoreState();
}

class _StudentMTestScoreState extends State<StudentMTestScore> {
  List<MTestScore> mScore = [];

  @override
  void initState() {
    mScore = widget.studentDetail.mTestScore;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mScore.length,
        itemBuilder: (BuildContext context, int index) {
          return MTestTable(mScore[index]);
        });
  }
}

/*
  DataTable _getDataTable({required List<MTestScore> score}) {
    return DataTable(
      horizontalMargin: 10.0,
      columnSpacing: 28.0,
      dataRowHeight: 30.0,
      border: TableBorder.all(),
      columns: _getColumns(),
      rows: _getRows(score: score),
    );
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumns = [
      DataColumn(label: Text('일자')),
      DataColumn(label: Text('국어')),
      DataColumn(label: Text('수학')),
      DataColumn(label: Text('영어')),
      DataColumn(label: Text('한국사')),
      DataColumn(label: Text('탐구1')),
      DataColumn(label: Text('탐구2')),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<MTestScore> score}) {
    List<DataRow> dataRow = [];
    if (score.length > 0) {
      for (var i = 0; i < score.length; i++) {
        dataRow.add(
          DataRow(
            cells: [
              DataCell(Text("${score[i].tYear}/${score[i].tMonth}")),
              DataCell(Text(score[i].koreanRank.toString())),
              DataCell(Text(score[i].mathRank.toString())),
              DataCell(Text(score[i].engRank.toString())),
              DataCell(Text(score[i].historyRank.toString())),
              DataCell(Text(score[i].tam1Rank.toString())),
              DataCell(Text(score[i].tam2Rank.toString())),
            ],
          ),
        );
      }
    }
    return dataRow;
  }
}

   */

class MTestTable extends StatelessWidget {
  MTestTable(this._score);

  final MTestScore _score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(child: Text("${_score.tYear}년 ${_score.tMonth}월 시행"),),
          SizedBox(height: 10.0,),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            //columnWidths: {0: FixedColumnWidth(70.0), 1: FlexColumnWidth()},
            children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text("과목"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text("점수"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text("백분율"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text("등급"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //타이틀 라인
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text("국어"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.koreanStdScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.koreanPercent.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.koreanRank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //국어
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text("수학"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.mathStdScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.mathPercent.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.mathRank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //수학
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text("영어"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.engScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(""),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.engRank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //영어
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text("한국사"),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.historyScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(""),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.historyRank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //한국사
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text(_score.tam1Gwamok.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam1StdScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam1Percent.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam1Rank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //탐구1
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Container(
                      child: Text(_score.tam2Gwamok.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam2StdScore.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam2Percent.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: Text(_score.tam2Rank.toString()),
                      height: 32.0,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ), //탐구2
            ],
          ),
        ],
      ),
    );
  }
}
