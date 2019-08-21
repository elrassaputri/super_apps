import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
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
String username = '955139';
String onLocation = 'NOK';
bool changeMessage = false;
Location location = Location();
Map<String, double> currentLocation;

class FingerPrintAbsen extends StatefulWidget {
  FingerPrintAbsen({Key key}) : super(key: key);

  _FingerPrintAbsen createState() => new _FingerPrintAbsen();
}

class _FingerPrintAbsen extends State<FingerPrintAbsen> {
  String _timeString;
  var data;

  sp_username() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username','98180052');
      prefs.commit();
      username = (prefs.getString('username')??'');
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
    var url_api = api.ListApi.status_absen;
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
      final uri = api.ListApi.absen;
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
      String responseBody = response.body;
      final dataResponse = json.decode(response.body);
      message = dataResponse['message'];
      changeMessage = true;
      getStatusMasuk();
      print(responseBody);
    } else {
      message = "Super App tidak dapat mendapatkan lokasi anda!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    getImei();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Theme.Colors.backgroundAbsen,
        child: Column(
          crossAxisAlignment: prefix0.CrossAxisAlignment.center,
          mainAxisAlignment: prefix0.MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: heightDevice,
              padding: prefix0.EdgeInsets.only(
                  top: heightDevice * .1, bottom: heightDevice * .1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: prefix0.EdgeInsets.only(
                        left: widthDevice * .05, right: widthDevice * .05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _statusOnLocation(),
                        Container(
                          child: Text(_timeString,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: prefix0.FontWeight.bold)),
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
                              if (onLocation == true) {
                                if (jenisAbsen == 'masuk') {
                                  Future.delayed(Duration(milliseconds: 800))
                                      .then((_) {
                                    final snackBar = SnackBar(
                                        content: Text(message),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ));
                                    Scaffold.of(context).showSnackBar(snackBar);
                                    changeMessage = !changeMessage;
                                  });
                                } else if (jenisAbsen == 'pulang') {
                                  Future.delayed(Duration(milliseconds: 800))
                                      .then((_) {
                                    final snackBar = SnackBar(
                                        content: Text(message),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ));
                                    Scaffold.of(context).showSnackBar(snackBar);
                                    changeMessage = !changeMessage;
                                  });
                                } else if (jenisAbsen == 'false') {
                                  Future.delayed(Duration(milliseconds: 800))
                                      .then((_) {
                                    final snackBar = SnackBar(
                                        content: Text(message),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ));
                                    Scaffold.of(context).showSnackBar(snackBar);
                                    changeMessage = !changeMessage;
                                  });
                                }
                              } else {
                                Future.delayed(Duration(milliseconds: 800))
                                    .then((_) {
                                  final snackBar = SnackBar(
                                      content: Text(message),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  changeMessage = !changeMessage;
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
          ],
        ),
      ),
    );
  }
}
