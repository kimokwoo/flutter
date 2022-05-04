import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentModel.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentScore extends StatefulWidget {
  final StudentModel studentDetail;
  StudentScore({required this.studentDetail});

  @override
  State<StudentScore> createState() => _StudentScoreState();
}

class _StudentScoreState extends State<StudentScore> {
  List<Score> _score11 = [];
  List<Score> _score12 = [];
  List<Score> _score21 = [];
  List<Score> _score22 = [];
  List<Score> _score31 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _score11 = widget.studentDetail.schoolScore.score11;
    _score12 = widget.studentDetail.schoolScore.score12;
    _score21 = widget.studentDetail.schoolScore.score21;
    _score22 = widget.studentDetail.schoolScore.score22;
    _score31 = widget.studentDetail.schoolScore.score31;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Center(child: Text("교과목별 평균 등급"),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: DataTable(
                    horizontalMargin: 10.0,
                    columnSpacing: 28.0,
                    dataRowHeight: 30.0,
                    border: TableBorder.all(),
                    columns: <DataColumn>[
                      DataColumn(label: Text('국어')),
                      DataColumn(label: Text('수학')),
                      DataColumn(label: Text('영어')),
                      DataColumn(label: Text('사회')),
                      DataColumn(label: Text('과학')),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(widget.studentDetail.koreanScore.toString())),
                          DataCell(Text(widget.studentDetail.mathScore.toString())),
                          DataCell(Text(widget.studentDetail.englishScore.toString())),
                          DataCell(Text(widget.studentDetail.socialScore.toString())),
                          DataCell(Text(widget.studentDetail.scienceScore.toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              const Center(child: Text("학기별 평균등급 그래프"),),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: const Color(0xff313723)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: const Color(0xff4d4837),
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Color(0xff4d4c37),
                                strokeWidth: 1,
                              );
                            },
                          ),

                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                              reservedSize: 42,
                              interval: 1,
                              getTitlesWidget: leftTitleWidgets),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: bottomTitleWidgets,
                              )
                            )
                          ),

                          borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: const Color(0xff4d3745), width: 2)),
                          minX: 0,
                          maxX: 6,
                          //minY: 0,
                          //maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(1, double.parse(widget.studentDetail.schoolScore.scoreAverage11!)),
                                FlSpot(2, double.parse(widget.studentDetail.schoolScore.scoreAverage12!)),
                                FlSpot(3, double.parse(widget.studentDetail.schoolScore.scoreAverage21!)),
                                FlSpot(4, double.parse(widget.studentDetail.schoolScore.scoreAverage22!)),
                                FlSpot(5, double.parse(widget.studentDetail.schoolScore.scoreAverage31!)),
                              ],
                              isCurved: false,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                              ),
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text("1학년 1학기"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getDataTable(score: _score11),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text("1학년 2학기"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getDataTable(score: _score12),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text("2학년 1학기"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getDataTable(score: _score21),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text("2학년 2학기"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getDataTable(score: _score22),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text("3학년 1학기"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getDataTable(score: _score31),
                    ],
                  ),
                  Container(
                    width: 100.0,
                    height: 50.0,
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.w400,
      fontSize: 15.0,
    );

    Widget text = const Text("");
    switch (value.toInt()) {
      case 1:
        text = const Text('1-1',style: style,);
        break;
      case 2:
        text = const Text('1-2',style: style,);
        break;
      case 3:
        text = const Text('2-1',style: style,);
        break;
      case 4:
        text = const Text('2-1',style: style,);
        break;
      case 5:
        text = const Text('3-1',style: style,);
        break;
    }
    return Padding(padding: EdgeInsets.only(top: 8.0), child: text,);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.w400,
      fontSize: 15.0,
    );

    String text = "";
    switch (value.toInt()) {
      case 1:
        text = "1 ";
        break;
      case 2:
        text = "2 ";
        break;
      case 3:
        text = "3 ";
        break;
      case 4:
        text = "4 ";
        break;
      case 5:
        text = "5 ";
        break;
      case 6:
        text = "6 ";
        break;
      case 7:
        text = "7 ";
        break;
      case 8:
        text = "8 ";
        break;
      case 9:
        text = "9 ";
        break;
      default:
        return Container();
    }
    return Text(text, style: style,textAlign: TextAlign.center,);
  }

  DataTable _getDataTable({required List<Score> score}) {
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
      DataColumn(label: Text('과목')),
      DataColumn(label: Text('성적')),
    ];
    return dataColumns;
  }

  List<DataRow> _getRows({required List<Score> score}) {
    List<DataRow> dataRow = [];
    if (score.length > 0) {
      for (var i = 0; i < score.length; i++) {
        dataRow.add(DataRow(
          cells: [
            DataCell(Text(score[i].gwamokName.toString())),
            DataCell(Text(score[i].scoreRank != null
                ? score[i].scoreRank.toString()
                : score[i].scoreAbc.toString())),
          ],
        ));
      }
    }
    return dataRow;
  }
}
