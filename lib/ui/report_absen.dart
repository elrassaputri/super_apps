import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart'as api;

class ReportAbsen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _reportAbsenState();
  }
}


class _reportAbsenState extends State<ReportAbsen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    makeGetRequest();
    return Scaffold(
      body: Center(
        child: Text("testing"),
      ),
    );
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
    var nik   = "955139";

    final uri = api.Api.report_absen+"$nik/$date1/$date2";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri,headers: headers);

    var data = jsonDecode(response.body);
    var data_absensi = (data["data"] as List)
        .map((data) => new dataReport.fromJson(data))
        .toList();

    foreachHasil(data_absensi);
  }

  void foreachHasil(List<dataReport> data_absensi) {
    for (var ini = 0;ini < data_absensi.length;ini++){
      //TODO setstate
      print(data_absensi[ini].tanggal);
    }

  }
}

class dataReport{
  String tanggal;
  String jam_masuk;
  String jam_pulang;
  String keterangan;
  String message;
  String status;

  dataReport({this.tanggal,this.jam_masuk,this.jam_pulang,this.keterangan});

  factory dataReport.fromJson(Map<String, dynamic> parsedJson){

    return dataReport(
        tanggal: parsedJson['present_date'].toString(),
        jam_masuk : parsedJson['in_dtm'].toString(),
        jam_pulang: parsedJson['out_dtm'].toString(),
        keterangan: parsedJson['keterangan'].toString()
    );
  }
}