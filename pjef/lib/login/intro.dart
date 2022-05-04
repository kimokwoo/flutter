import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pjef/login/login.dart';
import 'package:pjef/student/studentList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  late SharedPreferences _prefs;
  int _pNo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _pNo = _prefs.getInt('no') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            child: Image.asset('image/intro_bg.jpg',
              fit: BoxFit.fill,
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText('Welcome to',
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                RotateAnimatedText('Pohang Girls\' Highschool',
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
              onFinished: () {
                _pNo != 0 ? Get.offAllNamed('/studentList/value?grade=0&ban=0') : Get.offAllNamed('/login');
              },
              totalRepeatCount: 1,
            )
          ),
        ],
      ),
    );
  }
}
