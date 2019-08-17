import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:super_apps/style/theme.dart' as Theme;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    double heightProfileImg = widthDevice * .4;
    double widthIconSizeDefault = 56.0;

    return Scaffold(
      body: Container(
        color: Theme.Colors.backgroundAbsen,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.only(left: 8.0, top: 64.0, right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 8.0),
                          width: heightProfileImg,
                          height: heightProfileImg,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/login_header.png")))),
                      Container(
                        width: widthDevice - (heightProfileImg + 16.0 + 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              '21190042',
                              style: prefix0.TextStyle(
                                  color: Colors.white,
                                  fontWeight: prefix0.FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                            Container(
                              margin: prefix0.EdgeInsets.only(top: 2.0),
                              child: Text(
                                'ASTO ARIANTO MIWANDA',
                                style: prefix0.TextStyle(
                                    color: Colors.white,
                                    fontWeight: prefix0.FontWeight.w500,
                                    fontSize: 16.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Staff Mobile Dev',
                                style: prefix0.TextStyle(
                                    color: Colors.white70, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, right: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  height: heightDevice - (heightProfileImg + 64.0 + 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(64.0)),
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'Laki - laki',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'Karawang, 2001-01-08',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'Islam',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'Active',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'Jakarta(HO), Jl.S.Parman kav 8',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Text(
                                'astomiw@gmail.com',
                                style: TextStyle(color: Colors.black87, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: prefix0.MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Container(
                              width: widthDevice - (16.0 + 32.0 + 16.0 + widthIconSizeDefault),
                              child: Column(
                                crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Mgr IT Development',
                                    style: TextStyle(color: Colors.black87, fontSize: 16.0),
                                  ),
                                  prefix0.SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    '810108 - BENEDICTUS DAMAR SURYO LAKSONO',
                                    style: TextStyle(color: Colors.black87, fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
