import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';
import '../absen_page.dart';
import '../main_menu_page.dart';
import '../profile_page.dart';
import 'package:super_apps/style/string.dart' as String;

class Menu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Menu();
  }
  
}

class _Menu extends State<Menu>{
  int _selectedIndex = 0;
  DateTime currentBackPressTime;

  Widget callPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return MainMenu();
        break;
      case 1:
        return Absen();
        break;
      case 2:
        return Profile();
        break;
      default:
        return MainMenu();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;

    return Scaffold(
      body: WillPopScope(
        child: callPage(_selectedIndex),
        onWillPop: onWillPop,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint),
            title: Text('Absen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show(String.text.msg_tap_again_to_exit, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return Future.value(false);
    }
    return Future.value(true);
  }

}