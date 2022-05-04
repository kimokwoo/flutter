import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omakase/drawers/mainDrawer.dart';
import '../constants.dart';
import '../main.dart';
import 'restMain.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  String _selectedValue = CountryValues.Korea;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        //leadingWidth: 70.0,
        title: Center(
          child: SvgPicture.asset(
            'svg/logo_omakase.svg',
            width: 80.0,
          ),
        ),
        actions: [
          DropdownButton(
            value: _selectedValue,
            items: CountryValues.countryChoices.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.notoSans(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
            underline: Container(),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _buildListView(context, _screenSize),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      iconSize: 30.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
          tooltip: '사케를 검색하시려면 이 버튼을 누르세요!!',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: '내역',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_membership),
          label: '멤버십',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_outline_outlined),
          label: '메세지함',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '프로필',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildListView(BuildContext context, Size _screenSize) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Row(
//타이틀
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '추천 오마카세',
                style: GoogleFonts.notoSans(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.black,
                ),
                iconSize: 20,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          //추천 오마카세 스크롤뷰
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          RestMain()));
                },
                child: Container(
                  height: 400.0,
                  width: 300.0,
                  // margin: EdgeInsets.only(
                  //   left: 10.0,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'image/recommend_imakase.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border),
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '스시 렌',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '오마카세 스시',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      '서울/청담',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 400.0,
                width: 300.0,
                // margin: EdgeInsets.only(
                //   left: 10.0,
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'image/recommend_imakase2.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '스시 렌',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '오마카세 스시',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    '서울/청담',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          //추천 사케
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: Row(
//타이틀
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '추천 사케',
                style: GoogleFonts.notoSans(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.black,
                ),
                iconSize: 20,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_sake.png',
                        width: 200.0,
                        height: 300.0,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '카모시비토 쿠헤이지 야마다니시키',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir(오두디지)',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_sake2.png',
                        width: 200.0,
                        height: 300.0,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '카모시비토 쿠헤이지 야마다니시키',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir(오두디지)',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_sake.png',
                        width: 200.0,
                        height: 300.0,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '카모시비토 쿠헤이지 야마다니시키',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir(오두디지)',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Eau Du Desir',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          //세프 스토리
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: Row(
//타이틀
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '세프 스토리',
                style: GoogleFonts.notoSans(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Colors.black,
                ),
                iconSize: 20,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_chef.png',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '스시 아라키 Sushi Araki',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '홍콩 침사추',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_chef2.png',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '스시 아라키 Sushi Araki',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '홍콩 침사추',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        'image/recommend_chef.png',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '스시 아라키 Sushi Araki',
                          style: GoogleFonts.notoSans(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '홍콩 침사추',
                          style: GoogleFonts.notoSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          //구루메 파터너
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: Row(
//타이틀
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '해외여행의 구루메 파트너',
                    style: GoogleFonts.notoSans(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '아시아, 태평양 17개 도시의 인기 맛집정보와 예약',
                    style: GoogleFonts.notoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '더보기',
                  style: GoogleFonts.notoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              'image/surf.png',
              width: _screenSize.width - 20.0,
              height: 200.0,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  'image/ico_google.png',
                  width: _screenSize.width / 2 - 10,
                  height: 50.0,
                  //fit: BoxFit.fitWidth,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  'image/ico_appstore.png',
                  width: (_screenSize.width / 2) - 10,
                  height: 50.0,
                  //fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
