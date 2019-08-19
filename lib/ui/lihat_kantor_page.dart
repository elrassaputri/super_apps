import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/theme.dart' as style;

import 'package:google_maps_flutter/google_maps_flutter.dart';


class lihat_kantor_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pageLihatKantor();
  }
}

class pageLihatKantor extends State<lihat_kantor_page> {

  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  Map<CircleId, Circle> circles = <CircleId,Circle>{};
  bool stop_state = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.175004, 106.793088),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-6.175004,106.793088),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future _add(String id,String latitude,String longitude,String witel,String address,String radius) async {
    final MarkerId markerId = MarkerId(id);

    final Uint8List markerIcon = await getBytesFromAsset('assets/images/lokasi_kantor.png', 150);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      icon:  BitmapDescriptor.fromBytes(markerIcon),
      position: LatLng(double.parse(latitude) ,double.parse(longitude)),
      infoWindow: InfoWindow(title: witel, snippet: address),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
    );

    CircleId ci = CircleId(id);
    final Circle circle = Circle(
        circleId: ci,
        radius: double.parse(radius),
        //radius: 100,
        center: LatLng(double.parse(latitude),double.parse(longitude)),
        fillColor: style.Colors.colorCircle,
        strokeColor: style.Colors.colorCircle

    );

    //setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
      circles[ci] = circle;
    //});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _makeGetRequest();
    //_loadUser();
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        circles: Set<Circle>.of(circles.values),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        icon: Icon(Icons.supervised_user_circle),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  _makeGetRequest() async {

    var latitude = "-6.175004";
    var longitude = "106.793088";

    final uri = api.Api.app_lihat_kantor+"$latitude/$longitude";
    print(uri);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri,headers: headers);

    var data = jsonDecode(response.body);
    var data_absensi = (data["data"] as List)
        .map((data) => new dataLokasi.fromJson(data))
        .toList();

    //setState(() {
      foreachHasil(data_absensi);
    //});



  }

  void foreachHasil(List<dataLokasi> data_lokasi) {
    print("ini"+data_lokasi.length.toString());


    for (var ini = 0;ini < data_lokasi.length;ini++){
      //TODO setstate

      print("almat"+data_lokasi[ini].alamat);

      _add(ini.toString(),data_lokasi[ini].latitude,data_lokasi[ini].longitude,data_lokasi[ini].witel,data_lokasi[ini].alamat,data_lokasi[ini].radius);

    }
    if(stop_state){
      setState(() {});
    }

    stop_state = false;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

//  void _loadUser() {
//    location.onLocationChanged().listen((value) {
//      setState(() {
//
//      });
//    });
//  }
}

class dataLokasi{
  String alamat;
  String longitude;
  String latitude;
  String id;
  String witel;
  String radius;

  dataLokasi({this.alamat,this.latitude,this.longitude,this.id,this.witel,this.radius});

  factory dataLokasi.fromJson(Map<String, dynamic> parsedJson){

    return dataLokasi(
      alamat: parsedJson['alamat'].toString(),
      latitude : parsedJson['latitude'].toString(),
      longitude: parsedJson['longitude'].toString(),
      id: parsedJson['no'].toString(),
      witel: parsedJson['witel'].toString(),
      radius: parsedJson['akurasi'].toString(),
    );
  }
}
