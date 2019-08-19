import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:super_apps/style/theme.dart' as Theme;
import 'package:flutter_svg/flutter_svg.dart';

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
    double widthIcon = 36.0;
    double widthDataProfile = 68.0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_profile.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
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
                                'Mobile Development',
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: heightDevice - (heightProfileImg + 64.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(32.0, heightDevice * .12, 32.0, 32.0),
                        margin: EdgeInsets.only(top: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                            AssetImage('assets/images/bg_detail_profile.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: prefix0.EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisSize: prefix0.MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/gender.svg',
                                      semanticsLabel: 'Gender',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'Laki - laki',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/brithday.svg',
                                      semanticsLabel: 'Brithday',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'Karawang, 2001-01-08',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/religion.svg',
                                      semanticsLabel: 'Religion',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'Islam',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/status.svg',
                                      semanticsLabel: 'Status',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'Active',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/office.svg',
                                      semanticsLabel: 'Office',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'Jakarta(HO), Jl.S.Parman kav 8',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/email.svg',
                                      semanticsLabel: 'Email',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Text(
                                      'astomiw@gmail.com',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
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
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/icon/profile_page/team.svg',
                                      semanticsLabel: 'Team',
                                      placeholderBuilder: (context) =>
                                          Icon(Icons.error),
                                      width: widthIcon,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    width: widthDevice -
                                        (16.0 + 32.0 + 16.0 + widthDataProfile),
                                    child: Column(
                                      crossAxisAlignment:
                                      prefix0.CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Mgr IT Development',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                        ),
                                        prefix0.SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          '810108 - BENEDICTUS DAMAR SURYO LAKSONO',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
