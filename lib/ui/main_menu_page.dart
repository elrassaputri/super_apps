import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var username = '';
class MainMenuPage extends StatefulWidget {
  MainMenuPage({Key key}) : super(key: key);

  _MainMenuPage createState() => new _MainMenuPage();
  
}

class _MainMenuPage extends State<MainMenuPage> {
  var data;

   sp_username() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username','98180052');
      prefs.commit();
      username = (prefs.getString('username')??'');
    });
  
  }

  @override
  void initState() {
    super.initState();    
    getDataMenu();
    sp_username();

  }

  Future<String> getDataMenu() async {
    //var url_api = 'http://10.204.200.8:3001/settings_super_apps/2/98180052';
    var url_api = api.ApiMainHome.menu;
    var response = await http.get(
      Uri.encodeFull(url_api +"1/"+username),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);

      print(data);
    });
    
    
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: new Text(
          "Test main " + username,
          style: new TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),        
      ),
    );
  }

}