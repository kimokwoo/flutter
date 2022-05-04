import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:omakase/restaurant/restMain.dart';
import 'package:omakase/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String _restName = "";
  int _idx = 0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network('https://menu.igarim.com/omacase/common/images/visual_video.mp4?v=1642695785');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _restName = _prefs.getString('rest_name') ?? '';
      _idx = _prefs.getInt('idx') ?? 0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffff3030),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return FractionallySizedBox(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            onSelected: choiceLanguage,
                            itemBuilder: (BuildContext context) {
                              return LanguageValues.languageChoices //constants.dat 이용
                                  .map((String choice) {
                                return PopupMenuItem<String>(
                                  child: Text(
                                    choice,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: choice,
                                );
                              }).toList();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Language',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'svg/logo_omakase.svg',
                        width: 200.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Discover hidden jems\n'
                                'where you can enjoy Sake\n'
                                'and Japanese food',
                            style: GoogleFonts.notoSans(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.blue,
                                padding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                side: BorderSide(color: Colors.white, width: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                              ),
                              onPressed: () {
                                Get.offAllNamed('/login');
                              },
                              child: Text(
                                'Log in',
                                style: GoogleFonts.notoSans(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.blue,
                                padding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                side: BorderSide(color: Colors.white, width: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                              ),
                              onPressed: () {
                                Get.offAllNamed('/register');
                              },
                              child: Text(
                                'Sign in',
                                style: GoogleFonts.notoSans(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceLanguage(String choice) {
    if(choice == LanguageValues.Chinese) {
      print('중국어');
    } else if(choice == LanguageValues.English) {
      print('영어');
    } else if(choice == LanguageValues.Korean) {
      print('한국어');
    } else if(choice == LanguageValues.Japanese) {
      print('일본어');
    }

  }
}
