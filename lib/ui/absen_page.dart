import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:super_apps/style//theme.dart' as Theme;
import 'package:intl/intl.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('kk:mm').format(now);
String imei;
String jenisAbsen = '';
String absenTitle = 'Absen Masuk';
String message = '';
String username = '';
String onLocation = 'NOK';
Location location = Location();
Map<String, double> currentLocation;

class Absen extends StatefulWidget {
  Absen({Key key}) : super(key: key);

  _FingerPrintAbsen createState() => new _FingerPrintAbsen();
}

class _FingerPrintAbsen extends State<Absen> {
  String _timeString;
  var data;

  sp_username() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
    });
  }

  getImei() async {
    var imeiId = await ImeiPlugin.getImei;
    setState(() {
      imei = imeiId;
    });
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  Widget _statusOnLocation() {
    onLocation = authLocation();
    if (onLocation == 'NOK') {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
          color: Theme.Colors.colorNotOnLocation,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
          color: Theme.Colors.colorOnLocation,
          shape: BoxShape.circle,
        ),
      );
    }
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    super.initState();
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
    getStatusMasuk();
    sp_username();
    getImei();
  }

  authLocation() {
    var loc;
    currentLocation == null ? loc = "NOK" : loc = "OK";
    return loc;
  }

  Future<String> getStatusMasuk() async {
    var url_api = api.Api.status_absen;
    var response = await http.get(Uri.encodeFull(url_api + username),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
//      print(data['data'][0]['status_absen']);
    });
    _jenisAbsen();
  }

  statusAbsen() {
    var status;
    data == null ? status = "null" : status = data['data'][0]['status_absen'];
    return status;
  }

  _jenisAbsen() {
    var status = statusAbsen();
    if (status == 'belum masuk') {
      setState(() {
        jenisAbsen = 'masuk';
        absenTitle = 'Absen Masuk';
      });
    } else if (status == 'sudah masuk') {
      setState(() {
        jenisAbsen = 'pulang';
        absenTitle = 'Absen Pulang';
      });
    } else if (status == 'sudah pulang') {
      setState(() {
        jenisAbsen = 'complete';
        absenTitle = 'Absen Completed';
      });
    } else {
      setState(() {
        jenisAbsen = 'null';
      });
    }
    print(status);
    print(jenisAbsen);
    print('asto');
    return jenisAbsen;
  }

  _postAbsen() async {
    onLocation = authLocation();
    if (onLocation == 'OK') {
      final uri = api.Api.absen;
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(
        uri,
        headers: headers,
        body: "nik=" +
            username +
            "&imei=" +
            imei +
            "&latitude=" +
            currentLocation["latitude"].toString() +
            "&longitude=" +
            currentLocation["longitude"].toString() +
            "&jenis_absen=" +
            _jenisAbsen(),
        encoding: encoding,
      );

      int statusCode = response.statusCode;
      final dataResponse = json.decode(response.body);
      message = dataResponse['message'];
      getStatusMasuk();
      print('testing post');
    } else {
      message = "Super App tidak dapat mendapatkan lokasi anda!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    getImei();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    double heightBottomNav = 85.0;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Theme.Colors.backgroundAbsen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: heightDevice),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: heightDevice * .1, bottom: heightDevice * .1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: widthDevice * .05,
                                  right: widthDevice * .05),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _statusOnLocation(),
                                  Container(
                                    child: Text(_timeString,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Builder(
                                    builder: (context) => GestureDetector(
                                      onTap: () {
                                        _postAbsen();
                                        if (onLocation == true){
                                          if (jenisAbsen == 'masuk') {
                                            Future.delayed(
                                                    Duration(milliseconds: 800))
                                                .then((_) {
                                              final snackBar = SnackBar(
                                                  content: Text(message),
                                                  action: SnackBarAction(
                                                    label: 'OK',
                                                    onPressed: () {
                                                      // Some code to undo the change.
                                                    },
                                                  ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          } else if (jenisAbsen == 'pulang') {
                                            Future.delayed(
                                                    Duration(milliseconds: 800))
                                                .then((_) {
                                              final snackBar = SnackBar(
                                                  content: Text(message),
                                                  action: SnackBarAction(
                                                    label: 'OK',
                                                    onPressed: () {
                                                      // Some code to undo the change.
                                                    },
                                                  ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          } else if (jenisAbsen == 'false') {
                                            Future.delayed(
                                                    Duration(milliseconds: 800))
                                                .then((_) {
                                              final snackBar = SnackBar(
                                                  content: Text(message),
                                                  action: SnackBarAction(
                                                    label: 'OK',
                                                    onPressed: () {
                                                      // Some code to undo the change.
                                                    },
                                                  ));
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          }
                                        } else {
                                          Future.delayed(
                                                  Duration(milliseconds: 800))
                                              .then((_) {
                                            final snackBar = SnackBar(
                                                content: Text(message),
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ));
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: widthDevice,
                                        child: Image.asset(
                                            'assets/images/absen_masuk_fingerprint.gif'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 32),
                                    child: Text(absenTitle,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
