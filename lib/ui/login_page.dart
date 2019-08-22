import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:super_apps/style//theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'package:super_apps/api/api.dart' as api;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.Colors.backgroundLogin,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          prefix0.SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Theme.Colors.backgroundLogin,
                margin: const EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: new Image(
                          image: new AssetImage('assets/images/login_header.png')),
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
                                labelStyle:
                                TextStyle(color: Theme.Colors.colorTextWhite)),
                            keyboardType: TextInputType.text,
                            controller: usernameController,
                            style: TextStyle(color: Theme.Colors.colorTextWhite),
                          ),
                          TextField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: "********",
                                  hintStyle:
                                  TextStyle(color: Theme.Colors.colorTextWhite),
                                  labelText: "Password",
                                  fillColor: Theme.Colors.colorTextWhite,
                                  labelStyle:
                                  TextStyle(color: Theme.Colors.colorTextWhite)),
                              obscureText: true,
                              controller: passwordController,
                              style: TextStyle(color: Theme.Colors.colorTextWhite))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 150,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          makePostRequest();
                        },
                        child: Text("Login"),
                        color: Theme.Colors.bacgroundButton,
                        textColor: Theme.Colors.colorTextWhite,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ]
      ),
    );
  }
}

makePostRequest
    () async {
  final uri = api.Api.app_login;
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
