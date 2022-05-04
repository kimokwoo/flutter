import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pjef/models/studentBriefModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StudentPhotoList extends StatefulWidget {
  const StudentPhotoList({Key? key}) : super(key: key);

  @override
  _StudentPhotoListState createState() => _StudentPhotoListState();
}

class _StudentPhotoListState extends State<StudentPhotoList> {
  Future<List<StudentBriefModel>>? students;
  final studentListKey = GlobalKey<_StudentPhotoListState>();
  int _banValue = 1;
  int _gradeValue = 1;
  String _banTitle = BanValues.Ban1;
  String _gradeTitle = GradeValues.Grade1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _banValue = int.parse(Get.parameters['ban']!);
    _gradeValue = int.parse(Get.parameters['grade']!);
    if (_gradeValue == 0) _gradeValue = 1;
    if (_banValue == 0) _banValue = 1;
    makeGradeText(_gradeValue);
    makeBanText(_banValue);
    students = getStudentList(_banValue, _gradeValue);
  }

  Future<List<StudentBriefModel>> getStudentList(
      int? banValue, int? gradeValue) async {
    http.Response response;
    List<StudentBriefModel> students;
    var url = Uri.parse("http://pjef.org/api/get_student_list.php");

    response = await http.post(url,
        body: {'grade': gradeValue.toString(), 'ban': banValue.toString()});
    if (kDebugMode) {
      print(response.body);
    }
    students = jsonDecode(response.body).map<StudentBriefModel>((json) {
      return StudentBriefModel.fromJson(json);
    }).toList();

    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생사진'),
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
            Get.offNamed('/studentScoreList/value?grade=$_gradeValue&ban=$_banValue');
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: '학생명렬',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: '성적순',
            icon: Icon(Icons.cast_for_education),
          ),
          BottomNavigationBarItem(
            label: '학생사진',
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
                      onSelected: choiceGrade,
                      itemBuilder: (BuildContext context) {
                        return GradeValues.gradeChoices.map((String choice) {
                          return PopupMenuItem<String>(
                            child: Text(
                              choice,
                            ),
                            value: choice,
                          );
                        }).toList();
                      },
                      child: Row(
                        children: [
                          Text(
                            _gradeTitle,
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
                      onSelected: choiceBan,
                      itemBuilder: (BuildContext context) {
                        return BanValues.banChoices.map((String choice) {
                          return PopupMenuItem<String>(
                            child: Text(
                              choice,
                            ),
                            value: choice,
                          );
                        }).toList();
                      },
                      child: Row(
                        children: [
                          Text(
                            _banTitle,
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
                              '/studentPhotoList/value?grade=$_gradeValue&ban=$_banValue';
                          Get.offNamed(href);
                        },
                        child: const Text("검색"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<StudentBriefModel>>(
                    future: students,
                    builder: (BuildContext context, AsyncSnapshot ss) {
                      if (!ss.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return GridView.builder(
                          itemCount: ss.data?.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                            childAspectRatio: 1 / 1.7, //item 의 가로 1, 세로 2 의 비율
                            mainAxisSpacing: 10, //수평 Padding
                            crossAxisSpacing: 10, //수직 Padding
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var data = ss.data?[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed('/studentDetail/value?no=${data.no}');
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Image(
                                      image: NetworkImage("http://pjef.org/student/pict/" +
                                          data.photo),
                                    ),
                                    Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      color: Colors.white70,
                                      child: Text(
                                        '${data.no} ${data.name}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void choiceGrade(String choice) {
    if (choice == GradeValues.Grade1) {
      setState(() {
        _gradeValue = 1;
      });

    } else if (choice == GradeValues.Grade2) {
      setState(() {
        _gradeValue = 2;
      });

    } else if (choice == GradeValues.Grade3) {
      setState(() {
        _gradeValue = 3;
      });

    }

    setState(() {
      _gradeTitle = choice;
    });
  }

  void makeGradeText(int grade) {
    setState(() {
      _gradeTitle = grade.toString() + '학년';
    });
  }

  void makeBanText(int ban) {
    if (ban == 0) {
      setState(() {
        _banTitle = '전체반';
      });
    } else {
      setState(() {
        _banTitle = ban.toString() + '반';
      });
    }
  }

  void choiceBan(String choice) {
    if (choice == BanValues.Ban1) {
      setState(() {
        _banValue = 1;
      });

    } else if (choice == BanValues.Ban2) {
      setState(() {
        _banValue = 2;
      });

    } else if (choice == BanValues.Ban3) {
      setState(() {
        _banValue = 3;
      });

    } else if (choice == BanValues.Ban4) {
      setState(() {
        _banValue = 4;
      });

    } else if (choice == BanValues.Ban5) {
      setState(() {
        _banValue = 5;
      });

    } else if (choice == BanValues.Ban6) {
      setState(() {
        _banValue = 6;
      });

    } else if (choice == BanValues.Ban7) {
      setState(() {
        _banValue = 7;
      });

    } else if (choice == BanValues.Ban8) {
      setState(() {
        _banValue = 8;
      });

    } else if (choice == BanValues.Ban9) {
      setState(() {
        _banValue = 9;
      });

    }

    setState(() {
      _banTitle = choice;
    });
  }
}

class GradeValues {
  static const String Grade1 = '1학년';
  static const String Grade2 = '2학년';
  static const String Grade3 = '3학년';

  static const List<String> gradeChoices = <String>[
    Grade1,
    Grade2,
    Grade3,
  ];
}

class BanValues {
  static const String Ban1 = '1반';
  static const String Ban2 = '2반';
  static const String Ban3 = '3반';
  static const String Ban4 = '4반';
  static const String Ban5 = '5반';
  static const String Ban6 = '6반';
  static const String Ban7 = '7반';
  static const String Ban8 = '8반';
  static const String Ban9 = '9반';

  static const List<String> banChoices = <String>[
    Ban1,
    Ban2,
    Ban3,
    Ban4,
    Ban5,
    Ban6,
    Ban7,
    Ban8,
    Ban9,
  ];
}
