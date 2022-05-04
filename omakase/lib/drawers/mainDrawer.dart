import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MainDrawer extends StatefulWidget {

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _restName = "";
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _restName = _prefs.getString('rest_name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          //Here you place your menu items
          DrawerHeader(
              child: Text(_restName),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Menu', style: TextStyle(fontSize: 15)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Restaurant', style: TextStyle(fontSize: 15)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('Chef Story', style: TextStyle(fontSize: 15)),
            onTap: () {
              // Here you can give your route to navigate
              //Navigator.of(context).pop();
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Photo Gallery', style: TextStyle(fontSize: 15)),
            onTap: () {
              // Here you can give your route to navigate
              //Navigator.of(context).pop();
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.book_outlined),
            title: Text('Blog & YouTube', style: TextStyle(fontSize: 15)),
            onTap: () {
              // Here you can give your route to navigate
              //Navigator.of(context).pop();
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Log Out', style: TextStyle(fontSize: 15)),
            onTap: () {
              _prefs.clear();
              Get.offAllNamed('/login');
            },
          ),
          Divider(height: 3.0),
        ],
      ),
    );
  }
}
