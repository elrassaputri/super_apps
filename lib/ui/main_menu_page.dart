import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:super_apps/style/theme.dart' as Theme;
import 'package:carousel_pro/carousel_pro.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  mainMenuHeaderLogo() {
    return Container(
      height: 54.0,
      child: Image.asset('assets/images/logo_ta_putih.png'),
    );
  }
  mainMenuHeaderSearch() {
    TextEditingController searchController = new TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      padding: EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextField(
        autocorrect: true,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 14.0,
        ),
        controller: searchController,
        decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 14.0,
            ),
            hintText: 'Search application',
            border: InputBorder.none,
            suffixIcon: IconButton(
              iconSize: 24.0,
              icon: Icon(Icons.search),
              onPressed: () {
                print(searchController.text);
              },
            )),
      ),
    );
  }
  mainMenuHeader() {
    return Container(
      padding: EdgeInsets.only(top: 46.0),
      color: Theme.Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[mainMenuHeaderLogo()],
          ),
        ),
      ),
    );
  }
  mainMenuItem({String icon, String title, int numApp, Function onClick}) {
    Widget itemSubTitle = Container(
      padding: const EdgeInsets.only(top: 1.5),
      child: Text(numApp.toString() + ' Applications',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
    );

    if (numApp == 1) {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Application',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    }
    if (title == 'Video') {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Video',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 46.0,
            child: Image.asset(icon),
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
      ),
    );
  }

  Material headerMaterial() {
    return Material(
      color: Theme.Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[mainMenuHeaderLogo(), mainMenuHeaderSearch()],
          ),
        ),
      ),
    );
  }
  Material mainMenuSlideShowImage() {
    Widget mainMenuSlideShowImage = Container(
      color: Colors.red,
      height: 350,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/login_header.png'),
          AssetImage('assets/images/absen_masuk_fingerprint.gif'),
          AssetImage('assets/images/login_header.png'),
          AssetImage('assets/images/absen_masuk_fingerprint.gif'),
        ],
        autoplay: false,
        dotBgColor: Theme.Colors.transparent,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.cyan,
        dotSize: 4.0,
      ),
    );
    return Material(
      color: Colors.yellow,
      child: Container(
        color: Colors.green,
        child: ListView(
//          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[mainMenuSlideShowImage],
        ),
      ),
    );
  }
  Material mainMenuMyItemsBackup(String icon, String headline, int numApp) {
    return Material(
      color: Colors.white,
      elevation: 1.8,
      shadowColor: Colors.black87,
      borderRadius: BorderRadius.circular(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Material(
                    color: Theme.Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 46.0,
                        child: Image.asset(icon),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: <Widget>[
                          Text(headline,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Theme.Colors.iconMainMenu,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )),
                  Container(
                    child: Text(numApp.toString() + ' Applications',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.grey[600])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  mainMenuStaggeredGridViewPage() {
    return StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        children: <Widget>[
          mainMenuHeader(),
//            SlideShowImage(),
          /*
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
          MyItems('assets/icon/main_menu_page/document_management.png',
              "Total Views"),
         */
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 170.0),
//            StaggeredTile.extent(2, 350.0),
          StaggeredTile.extent(1, 316.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(2, 240.0),
          StaggeredTile.extent(2, 120.0),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;
    Widget mainMenuSlideShow = Container(
      height: widthDevice * .5,
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
      body: Container(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  mainMenuHeader(),
                  mainMenuSlideShow,
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: 16.0, right: 16.0, bottom: 32.0, left: 16.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                crossAxisCount: 2,
                childAspectRatio: 1.33,
                children: <Widget>[
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('human capital');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/human_capital.png',
                          title: 'Human Capital',
                          numApp: 11,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('document management');
                        },
                        child: mainMenuItem(
                          icon:
                              'assets/icon/main_menu_page/document_management.png',
                          title: 'Document Management',
                          numApp: 2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('project');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/project.png',
                          title: 'Project',
                          numApp: 1,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('supply chain');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/supply_chain.png',
                          title: 'Supply Chain',
                          numApp: 5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('finance');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/finance.png',
                          title: 'FINANCE',
                          numApp: 2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('oss');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/oss.png',
                          title: 'OSS',
                          numApp: 8,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('tools');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/tools.png',
                          title: 'Tools',
                          numApp: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('video');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/video.png',
                          title: 'Video',
                          numApp: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('link');
                        },
                        child: mainMenuItem(
                          icon: 'assets/icon/main_menu_page/LINK.png',
                          title: 'Link',
                          numApp: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
