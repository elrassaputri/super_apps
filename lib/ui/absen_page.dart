import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:super_apps/style//theme.dart' as theme;
import 'package:intl/intl.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/string.dart' as string;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('kk:mm').format(now);
String imei;
String jenisAbsen = '';
String absenTitle = 'Absen Masuk';
String message = '';
String nik = '';
String onLocation = 'NOK';
bool showToast = false;
Location location = Location();
Map<String, double> currentLocation;
ProgressDialog pr;

class Absen extends StatefulWidget {
  Absen({Key key}) : super(key: key);

  _Absen createState() => new _Absen();
}

class _Absen extends State<Absen> {
  String _timeString;
  var data;
  static const platform = const MethodChannel('samples.flutter.io/location');
  bool mocklocation = false;

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
      getStatusMasuk();
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
          color: theme.Colors.colorNotOnLocation,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
          color: theme.Colors.colorOnLocation,
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
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
    getNik();
    getImei();
  }

  authLocation() {
    var loc;
    currentLocation == null ? loc = "NOK" : loc = "OK";
    return loc;
  }

  Future<String> getStatusMasuk() async {
    var url_api = api.Api.status_absen;
    var response = await http.get(Uri.encodeFull(url_api + nik),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
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
    return jenisAbsen;
  }

  _postAbsen() async {
    onLocation = authLocation();
    print(onLocation);
    if (onLocation == 'OK') {
      pr.show();
      final uri = api.Api.absen;
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(
        uri,
        headers: headers,
        body: "nik=" +
            nik +
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

      pr.hide();
      final dataResponse = json.decode(response.body);
      message = dataResponse['message'];
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      getStatusMasuk();
    } else {
      message = string.text.msg_lokasi_tidak_ada;
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    getImei();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: theme.Colors.backgroundAbsen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: heightDevice),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: heightDevice * .1, bottom: heightDevice * .1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3, // 20%
                                          child: Center(
                                            child: Text(
                                                "Belum Absen", style: TextStyle(color: Colors.white)
                                            )
                                          )
                                            //Text("Belum Absen", style: TextStyle(color: Colors.white))
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(" "),
                                        ),
                                        Expanded(
                                          flex: 3, // 20%
                                          child: Column(
                                                children: <Widget>[
                                                  Row(
                                                      children: <Widget>[
                                                          Container(
                                                                child: Center(
                                                                    child: Text("Absen Pulang",
                                                                    style: TextStyle(color: Colors.white)),
                                                                ),
                                                          ),
                                                      ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                          margin: EdgeInsets.only(left: 33.0),
                                                          child: Text("16.00", style: TextStyle(color: Colors.white))
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                                left: 50.0,
                                        ),
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: new BoxDecoration(
                                          color: Color(0xFFC1E4ED),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: new Container(
                                            child: Divider(
                                              thickness: 4,
                                              color: Color(0xFFC1E4ED),
                                              height: 36,
                                            )),
                                      ),
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: new BoxDecoration(
                                          color: Color(0xFFC1E4ED),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      //Text("OR", style: TextStyle(color: Colors.white)),
                                      Expanded(
                                        child: new Container(
                                            child: Divider(
                                              thickness: 3,
                                              color: Color(0xFF31A5C4),
                                              height: 36,
                                            )),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 50.0
                                        ),
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ]),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Center(
                                              child: Text(
                                                "Absen Masuk",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(color: Colors.white)
                                              ),
                                            )
                                        ),
                                        //Text("Belum Absen", style: TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Center(
                                              child: Text(
                                                  "08.00",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(color: Colors.white)
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
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
                                      },
                                      child: Container(
                                        width: widthDevice,
                                        child: Image.asset(
                                            string.text.uri_absen_masuk),
                                      ),
                                    ),
                                  ),
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
