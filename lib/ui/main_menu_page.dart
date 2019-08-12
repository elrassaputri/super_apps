import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as Theme;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double widthDevice;
  List<List<String>> listMenu = [
    [
      'assets/icon/main_menu_page/document_management.svg',
      'Document Management',
      '8'
    ],
    ['assets/icon/main_menu_page/finance.svg', 'FENANCE', '6'],
    ['assets/icon/main_menu_page/human_capital.svg', 'Human Capital', '2'],
    ['assets/icon/main_menu_page/LINK.svg', 'Link', '1'],
    ['assets/icon/main_menu_page/oss.svg', 'OSS', '5'],
    ['assets/icon/main_menu_page/project.svg', 'Project', '8'],
    ['assets/icon/main_menu_page/supply_chain.svg', 'Supply Chain', '1'],
    ['assets/icon/main_menu_page/tools.svg', 'Tools', '4'],
    ['assets/icon/main_menu_page/video.svg', 'Video', '11'],
  ];

  List<List<String>> listMenuTest = [
    
  ];

  mainMenuHeaderLogo() {
    return Container(
      height: 54.0,
      child: Image.asset('assets/images/logo_ta_putih.png'),
    );
  }

  mainMenuHeader() {
    return Container(
      padding: EdgeInsets.only(top: 36.0, bottom: 16.0),
      color: Theme.Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[mainMenuHeaderLogo()],
      ),
    );
  }

  mainMenuItem({String icon, String title, int numApp}) {
    Widget itemSubTitle;

    if (numApp == 1) {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Application',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    } else if (title == 'Video') {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Video',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    } else {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Applications',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 46.0,
          child: SvgPicture.asset(icon,
              placeholderBuilder: (context) => Icon(Icons.error)),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Theme.Colors.iconMainMenu,
            ),
          ),
        ),
        itemSubTitle,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;

    Widget mainMenuSlideShow = Container(
      height: widthDevice * .4,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/quotes_3.jpg'),
          AssetImage('assets/images/tis.jpg'),
        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 4),
        dotBgColor: Theme.Colors.transparent,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.cyan,
        dotSize: 4.0,
      ),
    );

    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.Colors.backgroundAbsen,
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [mainMenuHeader(), mainMenuSlideShow],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                crossAxisCount: 2,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print(listMenu[index][1]);
                        },
                        child: mainMenuItem(
                          icon: listMenu[index][0],
                          title: listMenu[index][1],
                          numApp: int.parse(listMenu[index][2]),
                        ),
                      ),
                    ),
                  );
                },
                childCount: listMenu == null ? 0 : listMenu.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
