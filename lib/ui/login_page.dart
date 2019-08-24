import 'dart:convert';
import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/style//theme.dart' as Theme;
import 'package:super_apps/ui/main_menu_page.dart';
import 'package:super_apps/ui/profile_page.dart';
import 'package:super_apps/ui/tabs/menu.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:super_apps/api/api.dart' as api;

import '../main.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _Login createState() => new _Login();
}


TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
BuildContext ctx;

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(content: new Text(value)));}

 class _Login extends State<Login> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ctx = context;
    //news();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.Colors.backgroundLogin,
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              color: Theme.Colors.backgroundLogin,
              margin: const EdgeInsets.only(top: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: new Image(
                        image:
                            new AssetImage('assets/images/login_header.png')),
                    alignment: Alignment.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              hintText: "XXXXXXXX",
                              icon: Icon(Icons.account_circle),
                              hintStyle:
                                  TextStyle(color: Theme.Colors.colorTextWhite),
                              labelText: "Username",
                              fillColor: Theme.Colors.colorTextWhite,
                              labelStyle: TextStyle(
                                  color: Theme.Colors.colorTextWhite)),
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          style: TextStyle(color: Theme.Colors.colorTextWhite),
                        ),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: "********",
                                hintStyle: TextStyle(
                                    color: Theme.Colors.colorTextWhite),
                                labelText: "Password",
                                fillColor: Theme.Colors.colorTextWhite,
                                labelStyle: TextStyle(
                                    color: Theme.Colors.colorTextWhite)),
                            obscureText: true,
                            controller: passwordController,
                            style:
                                TextStyle(color: Theme.Colors.colorTextWhite))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 150,
                    child:  pressLogin(),
                  )
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  void showSimpleFlushbar() {
    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String
      message: 'Hello from a Flushbar',
      // Even the button can be styled to your heart's content
      mainButton: FlatButton(
        child: Text(
          'Click Me',
          style: TextStyle(color: Theme.Colors.colorTextWhite),
        ),
        onPressed: () {},
      ),
      duration: Duration(seconds: 3),
      // Show it with a cascading operator
    ).show(context);
  }

  Future Islogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = (prefs.getString("username") ?? '');
    if(login != ''){
      Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context) =>new Menu()));
      //return true;
    } //return false;
  }

//  void news() {
//    setup().then((s) => {
//       //  Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context) => Profile()))
//    });
//  }

  @override
  void initState() {
    super.initState();
    Islogin();
  }
 }

class pressLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        onPressed: () async {
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text("SNACKBAR")));
          makePostRequest(usernameController.text.toString(),
            passwordController.text.toString());

        },
        child: Text("Login"),
        color: Theme.Colors.bacgroundButton,
        textColor: Theme.Colors.colorTextWhite,
      ),
    );
  }
}

makePostRequest(username, password) async {
  final uri = api.Api.login;
  print("url ::" + uri + "/" + username);
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: "username=${username}&password=${password}",
    encoding: encoding,
  );

  String responseBody = response.body;
  bool status = json.decode(responseBody)["status"];
  var message = json.decode(responseBody)["message"];

  if (status) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.commit();
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => new Menu()),
    );
  } else {
    Toast.show(message, ctx, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}

class baru extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Builder(
      builder: (context) => RaisedButton(
          child: Text('Show Snackbar'),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Show Snackbar'),
              duration: Duration(seconds: 3),
            ));
          }),
    );
  }
}