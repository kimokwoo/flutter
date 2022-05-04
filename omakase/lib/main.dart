import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'intro/intro.dart';
import 'intro/login.dart';
import 'intro/register.dart';
import 'restaurant/mainpage.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'restaurant/restMain.dart';


void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => Intro(),
        ),
        GetPage(
          name: '/login',
          page: () => LogIn(),
        ),
        GetPage(
          name: '/register',
          page: () => Register(),
        ),
        GetPage(
          name: '/restMain',
          page: () => RestMain(),
        ),
        GetPage(
          name: '/mainpage',
          page: () => MainPage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Omakase App',
      home: Intro(),
    );
  }
}

