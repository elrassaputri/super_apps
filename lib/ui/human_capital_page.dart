import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:super_apps/style/theme.dart' as Theme;
import 'package:super_apps/ui/absen_page.dart';
import 'package:super_apps/ui/lihat_kantor_page.dart';
import 'package:super_apps/ui/main_menu_page.dart';
import 'package:super_apps/ui/profile_page.dart';

class HumanCapital extends StatefulWidget {
  HumanCapital({Key key}) : super(key: key);

  _HumanCapital createState() => new _HumanCapital();
}

class _HumanCapital extends State<HumanCapital> {
  double widthDevice;
  List<List<String>> listMenu = [
    ['Absen', 'assets/images/human_capital_absen.png'],
    [
      'Report Absen',
      'assets/images/human_capital_report_absen.gif'
    ],
    [
      'Lihat Lokasi',
      'assets/images/human_capital_lokasi_kantor.gif'
    ],
  ];

  humanCapitalList({String icon, String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: prefix0.EdgeInsets.only(left: 32.0, bottom: 16.0),
          width: widthDevice - (widthDevice / 4 + 32.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          child: ClipRRect(
            borderRadius: new BorderRadius.only(
                topRight: prefix0.Radius.circular(15.0),
                bottomRight: prefix0.Radius.circular(15.0)),
            child: Image.asset(
              icon,
              width: widthDevice / 4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    int _selectedIndex = 0;

    Widget callPage(int selectedIndex) {
      switch (selectedIndex) {
        case 0:
          return MainMenu();
          break;
        case 1:
          return FingerPrintAbsen();
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Human Capital',
          style: prefix0.TextStyle(
              color: Colors.white, fontWeight: prefix0.FontWeight.w500),
        ),
        backgroundColor: Theme.Colors.backgroundAbsen,
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: Theme.Colors.backgroundHumanCapital,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.lightBlue,
                        onTap: () {
                          if (listMenu[index][0] == 'Absen') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FingerPrintAbsen()),
                            );
                          } else if (listMenu[index][0] == 'Report Absen') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FingerPrintAbsen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => lihat_kantor_page()),
                            );
                          }
                          print(listMenu[index][1]);
                        },
                        child: humanCapitalList(
                          icon: listMenu[index][1],
                          title: listMenu[index][0],
                        ),
                      ),
                    ),
                  );
                },
                childCount: listMenu == null ? 0 : listMenu.length,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Absen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
      ),
    );
  }
}
