import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late SharedPreferences _prefs;
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool _processing = false;

  int _idx = 0;
  int _poi_no =  0;
  String _rest_name = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _idx = _prefs.getInt('idx') ?? 0;
      _poi_no = _prefs.getInt('poi_no') ?? 0;
      _rest_name = _prefs.getString('rest_name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
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
                child: SvgPicture.asset(
                  'svg/logo_omakase.svg',
                  width: 120.0,
                )
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
                            labelText: 'Partner ID',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          controller: controllerPassword,
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.redAccent,
                            child: _processing == false ?
                            Text("로그인",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),): CircularProgressIndicator(
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
    var url = Uri.parse("https://manager.surfrising.com/api/omakasePartnerMemberAction.php");
    var data = {
      "login_id": controllerId.text,
      "login_pw": controllerPassword.text,
      "action" : "login",
    };

    var res = await http.post(url, body: data);
    setState(() {
      _processing = false;
    });
    if(res.statusCode == 200) {
      var resArr = jsonDecode(res.body);
      if(resArr['status'] == 1) {
        toastMessage(resArr['message']);
        _setPreferences(
            resArr['idx'],
            resArr['poi_no'],
            resArr['rest_name'],
        );
        Get.offAllNamed('/mainpage');

      } else if (resArr['status'] == 0) {
        toastMessage(resArr['message']);
      }
    } else {
      toastMessage('네트워크 오류');
    }
    print('Response status: ${res.statusCode}');
    print('Response body: ${jsonDecode(res.body)}');

  }

  _setPreferences(int idx, int poi_no, String rest_name) async {
    setState(() {
      _prefs.setInt('idx', idx);
      _prefs.setInt('poi_no', poi_no);
      _prefs.setString('rest_name', rest_name);
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
        fontSize: 14.0
    );
  }
}
