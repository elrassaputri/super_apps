import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style//theme.dart' as Theme;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:super_tooltip/super_tooltip.dart';

int lengthReportAbsen = 0;
List<String> tanggalAbsen = [];
List<String> jamMasukAbsen = [];
List<String> jamPulangAbsen = [];
List<String> ketAbsen = [];
String message;
String status;

class ReportPage extends StatefulWidget {
  //static const String routeName = '/material/tooltips';

  _ReportPageState createState() => new _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  SuperTooltip tooltip;

  GlobalKey _containerKey = GlobalKey();

  List _keterangan = ["Mobile", "Finger", "Web", "Izin"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedKeterangan;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedKeterangan = _dropDownMenuItems[0].value;
    super.initState();
    makeGetRequest();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String keterangan in _keterangan) {
      items.add(
          new DropdownMenuItem(value: keterangan, child: new Text(keterangan)));
    }
    return items;
  }

  ketWidgetAbsen(String ket) {
    Widget ketIcon;
    switch (ket) {
      case 'M' : {
        return ketIcon = Container(
          color: Colors.grey,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('M',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'F': {
        return ketIcon = Container(
          color: Colors.greenAccent,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('F',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'W': {
        return ketIcon = Container(
          color: Colors.lightBlueAccent,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('W',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'D': {
        return ketIcon = Container(
          color: Colors.green,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('D',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'S': {
        return ketIcon = Container(
          color: Colors.deepPurple,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('S',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'C': {
        return ketIcon = Container(
          color: Colors.deepOrangeAccent,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('C',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'I': {
        return ketIcon = Container(
          color: Colors.purpleAccent,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('I',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'T': {
        return ketIcon = Container(
          color: Colors.indigo,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('T',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      case 'G': {
        return ketIcon = Container(
          color: Colors.pinkAccent,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('G',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
      break;
      default : {
        return ketIcon = Container(
          color: Colors.grey,
          height: 25.0,
          // height of the button
          width: 25.0,
          // width of the button
          child: Center(
              child: Text('M',
                  style: TextStyle(
                      color: Colors
                          .white))),
        );
      }
    }
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
        popupDirection: TooltipDirection.down,
        arrowTipDistance: 10.0,
        content: new Material(
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(" Keterangan Absen:"),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: ClipOval(
                          child: Container(
                            color: Colors.grey,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('M',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(child: Text(" : Mobile")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.greenAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('F',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Fingerprint")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.lightBlueAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center( child: Text('W',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Web Absen")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.green,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('D',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : SPPD")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.deepPurple,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('S',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Sakit")),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: ClipOval(
                          child: Container(
                            color: Colors.deepOrangeAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('C',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(" : Cuti")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.purpleAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('I',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Izin")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.indigo,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('T',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Pengganti Hari Libur")),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.pinkAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('G',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : Penugasan Diluar")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));

    tooltip.show(_containerKey.currentContext);
  }

  final text = new Text(
    'Text here',
    style: new TextStyle(fontSize: 50.0),
  );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      //backgroundColor: Colors.redAccent,
      backgroundColor: Theme.Colors.backgroundAbsen,
      appBar: new AppBar(
        title: Text("widget.title"),
      ),
      body: new SafeArea(
        child: new Column(children: [
          new Expanded(
            flex: 2,
            child: new Container(
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              color: Theme.Colors.backgroundAbsen,
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tanggal',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width / 2.3,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2019), onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                "2019/08/19",
                                textAlign: TextAlign.center,
                              ),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Icon(Icons.date_range),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: width / 2.3,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2019), onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                "2019/08/19",
                                textAlign: TextAlign.center,
                              ),
                              Flexible(fit: FlexFit.tight, child: SizedBox()),
                              Icon(Icons.date_range),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Keterangan',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                      value: _selectedKeterangan,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 25),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        // makePostRequest();
                      },
                      child: Text("Filter"),
                      color: Theme.Colors.bacgroundButton,
                      textColor: Theme.Colors.colorTextWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Expanded(
              flex: 3,
              child: new Container(
                width: width,
                // this will give you flexible width not fixed widt
                color: Colors.white,
                //variable
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: StickyHeader(
                        header: new Container(
                          height: 50.0,
                          padding: prefix0.EdgeInsets.symmetric(horizontal: 16.0),
                          color: Colors.lightBlueAccent,
                          alignment: Alignment.centerLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                        child: new Text("No",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)))),
                                Expanded(
                                    child: new Text("Tanggal",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15))),
                                Expanded(
                                    child: new Text("Jam Masuk",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15))),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: new Text("Jam Pulang",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))),
                                ),
                                Expanded(
                                  child: Container(
                                      child: GestureDetector(
                                    onTap: onTap,
                                    child: Container(
                                      key: _containerKey,
                                      padding: EdgeInsets.only(left: 30),
                                      child: new Text("Ket",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  )),
                                ),
                              ]),
                        ),
                        content: Table(
                          children: List<int>.generate(
                                  lengthReportAbsen, (index) => index)
                              .map((item) => TableRow(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text((item + 1).toString()),
                                      ),
                                      Text(tanggalAbsen[item]),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(jamMasukAbsen[item]),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 18),
                                        child: Text(jamPulangAbsen[item]),
                                      ),
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: GestureDetector(
                                              child: ClipOval(
                                                child: ketWidgetAbsen(ketAbsen[item]),
                                              ),
                                            )),
                                      )
                                    ],
                                  ))
                              .toList(),
                        )),
                  ),
                ),
              )),
        ]),
      ),
    );
    //);
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _selectedKeterangan = selectedCity;
    });
  }

  makePostRequest() async {
    final uri = api.Api.app_login;
    //final uri = api.Api.app_login;
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Map<String, dynamic> body = {'id': ''};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: "id=2&test=3",
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(responseBody);
  }

  makeGetRequest() async {
    var date1 = "2016-01-6";
    var date2 = "2016-01-10";
    var nik = "955139";

    final uri = api.Api.report_absen + "$nik/$date1/$date2";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);

    var data = jsonDecode(response.body);
    var data_absensi = (data["data"] as List)
        .map((data) => new dataReport.fromJson(data))
        .toList();

    foreachHasil(data_absensi);
  }

  void foreachHasil(List<dataReport> data_absensi) {
    setState(() {
      lengthReportAbsen = data_absensi.length;
    });
    for (var ini = 0; ini < data_absensi.length; ini++) {
      //TODO setstate
      setState(() {
        tanggalAbsen.add(data_absensi[ini].tanggal);
        jamMasukAbsen.add(data_absensi[ini].jam_masuk);
        jamPulangAbsen.add(data_absensi[ini].jam_pulang);
        ketAbsen.add(data_absensi[ini].keterangan);
        message = data_absensi[ini].message;
        status = data_absensi[ini].status;
      });
    }
  }
}

class dataReport {
  String tanggal;
  String jam_masuk;
  String jam_pulang;
  String keterangan;
  String message;
  String status;

  dataReport({this.tanggal, this.jam_masuk, this.jam_pulang, this.keterangan});

  factory dataReport.fromJson(Map<String, dynamic> parsedJson) {
    return dataReport(
        tanggal: parsedJson['present_date'].toString(),
        jam_masuk: parsedJson['in_dtm'].toString(),
        jam_pulang: parsedJson['out_dtm'].toString(),
        keterangan: parsedJson['keterangan'].toString());
  }
}
