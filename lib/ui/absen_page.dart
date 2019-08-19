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
//var username = '955139';
var username = '';

var absen = 'false';
bool onLocation = false;

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

   getImei() async{    
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

  void _changeStatusAbsen() {
    if (onLocation == true) {
      if (absen == 'false') {
        setState(() {
          absen = 'masuk';
        });
      } else if (absen == 'masuk') {
        setState(() {
          absen = 'pulang';
        });
      } else {
        setState(() {
          absen = 'false';
        });
      }
    }
  }

  Widget _textStatusAbsen() {
    if (absen == 'false') {
      return Text('Absen Masuk',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold));
    } else if (absen == 'masuk') {
      return Text('Absen Pulang',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold));
    } else if (absen == 'pulang') {
      return Text('Absen Complete',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold));
    }
  }

  Widget _statusOnLocation() {
    if (onLocation == false) {
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
    getImei();
    _jenisAbsen();
    getStatusMasuk();
    sp_username();
  }

  authLocation() {
    var loc;
    currentLocation == null
              ? loc = "NOK"
              : loc = "OK";
    return loc;
  }

  Future<String> getStatusMasuk() async {
    var url_api = api.ListApi.status_absen;
    var response = await http.get(
      Uri.encodeFull(url_api + username),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);

      print(data['data'][0]['status_absen']);
    });
    
    
   }

   statusAbsen() {
    var status;
                  data == null
              ? status = "null"
              : status = data['data'][0]['status_absen'];
    return status;
  }

   _jenisAbsen(){
      var status = statusAbsen();
      var jenisAbsen;
      if (status == 'belum masuk') {
        setState(() {
          jenisAbsen = 'masuk';
        });
      } else if (status == 'sudah masuk') {
        setState(() {
          jenisAbsen = 'pulang';
        });
      } else if (status == 'sudah pulang') {
        setState(() {
          jenisAbsen = 'complete';
        });
      }else{
        setState(() {
                  jenisAbsen='null';
                });
      }
          
      return jenisAbsen;
    }


_postAbsen() async {

  final uri = api.ListApi.absen;
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: "nik="+username+"&imei="+imei+"&latitude="+currentLocation["latitude"].toString()+"&longitude="+currentLocation["longitude"].toString()+"&jenis_absen="+_jenisAbsen(),
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;

  print(responseBody);
  
}

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Theme.Colors.backgroundAbsen,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.only(top: 50, left: 16, right: 16),
                  margin: EdgeInsets.only(bottom: 32),
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
                            _changeStatusAbsen();
                            if (onLocation == true) {
                              if (absen == 'masuk') {
                                Future.delayed(Duration(seconds: 1)).then((_) {
                                  final snackBar = SnackBar(
                                      content:
                                          Text('Semangat pagi pagi pagi!!!'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                });
                              } else if (absen == 'pulang') {
                                Future.delayed(Duration(milliseconds: 200))
                                    .then((_) {
                                  final snackBar = SnackBar(
                                      content: Text('Pulang lu sana!!!'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                });
                              } else if (absen == 'false') {
                                Future.delayed(Duration(seconds: 1)).then((_) {
                                  final snackBar = SnackBar(
                                      content: Text('loop back'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                });
                              }
                            } else {
                              Future.delayed(Duration(seconds: 1)).then((_) {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Mohon datang ke kantor untuk melakukan absen!!'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ));
                                Scaffold.of(context).showSnackBar(snackBar);
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
                        child: _textStatusAbsen(),
                      )
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
