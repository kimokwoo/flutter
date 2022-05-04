import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late SharedPreferences _prefs;
  String _pName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _pName = _prefs.getString('name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$_pName님 \n반갑습니다.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.brown,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/school_main.jpg'),
                fit: BoxFit.fill,
              ),
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text("코로나현황"),
            onTap: () {
              Get.offAllNamed('/coronaList/values?todo=');
            },
          ),
          ListTile(
            title: const Text("선생님"),
            onTap: () {
              Get.offAllNamed('/teacherList/values?school=0&gwamok=0');
            },
          ),
          ListTile(
            title: const Text("학생"),
            onTap: () {
              Get.offAllNamed('/studentList/values?ban=0&grade=0');
            },
          ),
          ListTile(
            title: const Text("시간표"),
            onTap: () {
              Get.offAllNamed('/classTimeSchedule/values?ban=1&grade=1');
            },
          ),
          ListTile(
            title: const Text("교육과정"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("생기부기재요령"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("학교급식"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("로그아웃"),
            onTap: () {
              _prefs.clear();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
