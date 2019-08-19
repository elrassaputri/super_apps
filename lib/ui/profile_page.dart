import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart' as api;

class profile_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _profile_page();
  }
}

class _profile_page extends State<profile_page>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    makeGetRequest();
    return Scaffold(

    );
  }
}

makeGetRequest() async
{
  var nik = "955139";
  final uri = api.Api.app_profile+"$nik/${api.Api.versi}r";
  print(uri);
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Response response = await get(uri,headers: headers);
  var data = jsonDecode(response.body);
  var data_profile = (data["data"] as List).map((data) => new
  dataProfile.fromJson(data)).toList();
  print(data_profile.length);
  foreachHasil(data_profile);
}

void foreachHasil(List<dataProfile> data_profile) {
  for (var ini = 0;ini < data_profile.length;ini++){
    //TODO setstate

    // provide data astro
    print(data_profile[ini].nama);
    print(data_profile[ini].jabatan);
    print(data_profile[ini].jenis_kelamin);
    print(data_profile[ini].tempat_tanggal_lahir);
    print(data_profile[ini].status_kerja);
    print(data_profile[ini].lokasi_kerja);
    print(data_profile[ini].email);
    print(data_profile[ini].atasan);
    print(data_profile[ini].foto);
  }

}

class dataProfile{

  String nama;
  String jabatan;
  String jenis_kelamin;
  String tempat_tanggal_lahir;
  String status_kerja ;
  String lokasi_kerja;
  String email;
  String atasan;
  String foto;


  dataProfile({this.nama,this.jabatan,this.jenis_kelamin,this.tempat_tanggal_lahir,this.status_kerja,this.lokasi_kerja,this.email,this.atasan,this.foto});

  factory dataProfile.fromJson(Map<String, dynamic> parsedJson){

    return dataProfile(
        nama: parsedJson['name'].toString(),
        jabatan : parsedJson['nama_posis'].toString(),
        jenis_kelamin: parsedJson['jenis_kelamin'].toString(),
        tempat_tanggal_lahir: (parsedJson['kota_lahir'].toString())+", "+parsedJson['tgl_lahir'].toString(),
        status_kerja: parsedJson['nama_status_kerja'].toString(),
        lokasi_kerja: parsedJson['psa'].toString(),
        email: parsedJson['mail'].toString(),
        atasan: (parsedJson['posisi_parent_1'].toString())+" \n"+parsedJson['name_parent_1'].toString(),
        foto: (parsedJson['foto'].toString()),
    );
  }
}