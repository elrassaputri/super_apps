
class Api{
  static var host = "http://10.204.200.8:3000/";
  static var app_profile = host+"data_profile/";
  static var versi = "1";
  static var uri = "http://10.204.200.8:3001/";

  // app sso
  static var app_login = host+"app_login.php";
  // app absen
  static var report_absen = uri+"report_absen/";
}

class ListApi{
  static var host = "http://10.204.200.8:3001/";
  static var status_absen = host+"status_masuk_absen/";
  static var absen =  host+"absensi";
  static var app_lihat_kantor = host+"lokasi_kantor/";
}

class ApiMainHome{
  static var host = "http://10.204.200.8:3001/";
  static var menu =  host+"settings_super_apps/";
}