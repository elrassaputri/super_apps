
class Api{
  // host
  static var host = "http://10.204.200.8:";

  // port
  static var p_absen = "3000";
  static var p_hrmista = "3001";
  static var p_sso = "3002";
  static var p_super_apps = "3003";

  // app sso
  static var login = host+p_sso+"/auth_post_sso/";

  // app hrmista
  static var profile = host+p_hrmista+"/data_profile/";

  // absen
  static var status_absen = host+p_absen+"/status_masuk_absen/";
  static var absen =  host+p_absen+"/absensi/";
  static var lihat_kantor = host+p_absen+"/lokasi_kantor/";
  static var report_absen = host+p_absen+"/report_absen/";

  // super apps
  static var menu =  host+p_super_apps+"/settings_super_apps/";

  // versi aplikasi
  static var versi = "1";

}