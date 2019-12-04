import 'package:flutter_app/pages/auth/fireBaseAuth/SignUp.dart';
import 'package:flutter_app/pages/auth/fireBaseAuth/SignIn.dart';
import 'package:flutter_app/pages/auth/fireBaseAuth/accept.dart';
import 'package:flutter_app/pages/auth/welcome.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//"/": (_) => new WebviewScaffold(
//url: "https://www.google.com",
//appBar: new AppBar(
//title: new Text("Widget webview"),
//),
//),

routes(){
  return {
    '/': (BuildContext context) => WelcomePage(),
    '/signUp': (BuildContext context) => SignUpFireBase(),
    '/SignIn': (BuildContext context) => SignInFireBase(),
    '/home': (BuildContext context) => MyHomePage(),
    '/accept': (BuildContext context) => Otp(),
  };
}