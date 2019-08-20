import 'package:flutter/material.dart';

class Api{
  static var host = "http://10.204.100.120/super/";
  static var app_login = host+"app_login.php";
  static var versi = "1";
}

class ListApi{
  static var host = "http://10.204.200.8:8087/";
  static var status_absen = host+"status_masuk_absen/";
  static var absen =  host+"absensi";

}

class ApiMainHome{
  static var host = "http://10.204.200.8:3001/";
  static var menu =  host+"settings_super_apps/";
}