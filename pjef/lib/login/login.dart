import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late SharedPreferences _prefs;
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  int _gubun = 2;
  bool _processing = false;

  int _pNo = 0;
  String _pName = '';
  int _pPower = 100;
  int _pGubun = 0;
  String _pType = '';
  int _pGrade = 0;
  int _pBan = 0;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _pNo = _prefs.getInt('no') ?? 0;
      _pName = _prefs.getString('name') ?? '';
      _pPower = _prefs.getInt('power') ?? 100;
      _pGubun = _prefs.getInt('gubun') ?? 0;
      _pType = _prefs.getString('type') ?? '';
      _pGrade = _prefs.getInt('grade') ?? 0;
      _pBan = _prefs.getInt('ban') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50.0)),
              Center(
                child: Image(
                  image: AssetImage('image/school_logo.jpg'),
                ),
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: controllerId,
                          decoration: InputDecoration(
                            labelText: 'Enter ID',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          controller: controllerPassword,
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _gubun,
                              onChanged: (value) {
                                setState(() {
                                  _gubun = 1;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                            Text(
                              '학생',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Radio(
                              value: 2,
                              groupValue: _gubun,
                              onChanged: (val) {
                                setState(() {
                                  _gubun = 2;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                            Text(
                              '교사',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.redAccent,
                            child: _processing == false
                                ? Text(
                                    "로그인",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : CircularProgressIndicator(
                                    backgroundColor: Colors.orangeAccent,
                                  ),
                            onPressed: () => loginUser(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _processing = true;
    });
    var url = Uri.parse("http://pjef.org/api/mobile_login.php");
    var data = {
      "user_id": controllerId.text,
      "user_pwd": controllerPassword.text,
      "site_pswd": _gubun.toString(),
    };

    var res = await http.post(url, body: data);
    if (res.statusCode == 200) {
      var resArr = jsonDecode(res.body);
      if (resArr['code'] == '200') {
        toastMessage('정상적으로 로그인 되었습니다.');
        var resResult = resArr['result'];
        var _grade =
            resResult['grade'] != '' ? int.parse(resResult['grade']) : 0;
        var _ban = resResult['ban'] != '' ? int.parse(resResult['ban']) : 0;
        _setPreferences(
            int.parse(resResult['no']),
            resResult['name'].toString(),
            int.parse(resResult['power']),
            int.parse(resResult['gubun']),
            resResult['type'].toString(),
            _grade,
            _ban);
        Get.offAllNamed('/studentList/value?grade=0&ban=0');
        
      } else if (resArr['code'] == '202') {
        toastMessage('ID 또는 Password가 등록되어 있지 않습니다.');
      }
    } else {
      toastMessage('네트워크 오류');
    }
    print('Response status: ${res.statusCode}');
    print('Response body: ${jsonDecode(res.body)}');

    setState(() {
      _processing = false;
    });
  }

  _setPreferences(int no, String name, int power, int gubun, String type,
      int grade, int ban) async {
    setState(() {
      _prefs.setInt('no', no);
      _prefs.setString('name', name);
      _prefs.setInt('power', power);
      _prefs.setInt('gubun', gubun);
      _prefs.setString('type', type);
      _prefs.setInt('grade', grade);
      _prefs.setInt('ban', ban);
    });
  }

  void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
