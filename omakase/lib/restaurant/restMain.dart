import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omakase/constants.dart';
import '../drawers/mainDrawer.dart';

class RestMain extends StatefulWidget {
  @override
  _RestMainState createState() => _RestMainState();
}

class _RestMainState extends State<RestMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: MainDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xffff3030),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    '스시 렌',
                    style: GoogleFonts.notoSans(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' ',
                    style: GoogleFonts.notoSans(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            expandedHeight: 274.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                //식당 대표사진 pageView
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                child: Stack(
                  children: [
                    PageViewWidget(),
                    Align(
                      alignment: Alignment(-0.9, 0.9),
                      child: GoogleText(
                        '스시 렌',
                          fontSize : 20.0,
                          fontWeight : FontWeight.w800,
                          color :Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,
                    vertical: 10.0),
                child: GoogleText(
                  '20세에 첫 일식에 입문해 20년의 수행을 거쳐 본격적인 '
                      '이타마에의 길에 들어선 도전이 기대되는 곳이다. 강남의 하이엔드 '
                      '업장인 스시 타츠와 스시 스미레를 거친 '
                      '이성준셰프의 진검승부가 기대된다.',
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,
                      vertical: 10.0),
                  child: GoogleText(
                    '20세에 첫 일식에 입문해 20년의 수행을 거쳐 본격적인 '
                        '이타마에의 길에 들어선 도전이 기대되는 곳이다. 강남의 하이엔드 '
                        '업장인 스시 타츠와 스시 스미레를 거친 '
                        '이성준셰프의 진검승부가 기대된다.',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,
                      vertical: 10.0),
                  child: GoogleText(
                    '20세에 첫 일식에 입문해 20년의 수행을 거쳐 본격적인 '
                        '이타마에의 길에 들어선 도전이 기대되는 곳이다. 강남의 하이엔드 '
                        '업장인 스시 타츠와 스시 스미레를 거친 '
                        '이성준셰프의 진검승부가 기대된다.',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,
                      vertical: 10.0),
                  child: GoogleText(
                    '20세에 첫 일식에 입문해 20년의 수행을 거쳐 본격적인 '
                        '이타마에의 길에 들어선 도전이 기대되는 곳이다. 강남의 하이엔드 '
                        '업장인 스시 타츠와 스시 스미레를 거친 '
                        '이성준셰프의 진검승부가 기대된다.',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,
                      vertical: 10.0),
                  child: GoogleText(
                    '20세에 첫 일식에 입문해 20년의 수행을 거쳐 본격적인 '
                        '이타마에의 길에 들어선 도전이 기대되는 곳이다. 강남의 하이엔드 '
                        '업장인 스시 타츠와 스시 스미레를 거친 '
                        '이성준셰프의 진검승부가 기대된다.',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int _currentPage = 0;
  List<String> _imageName = ["img01", "img02", "img03", "img04"];

  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 자동 스크롤 기능
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(_currentPage,
          duration: Duration(milliseconds: 20), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        itemCount: _imageName.length,
        itemBuilder: (context, index) {
          return Stack(children: [
            Image.asset('image/restaurant_detail_${_imageName[index]}.png'),
            Align(
              alignment: Alignment(0.9, 0.9),
              child: Text(
                '${_currentPage + 1} / ${_imageName.length}',
                style: GoogleFonts.notoSans(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ]);
        });
  }
}
