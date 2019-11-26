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
    '/test': (_) => new WebviewScaffold(
      url: "https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/authorize?response_type=code&client_id=0cf3f177-6d32-440c-a4e2-08cc84dbc3bb&redirect_uri=https://metalloinvest.sharepoint.com/sites/portal/PortalPages/home.aspx&%D1%81lient_secret=OLijLFc8Syld34P6%5BpAOJJIT%5B%5BRrMUM-&resource=https://metalloinvest.sharepoint.com",
      appBar: new AppBar(
        title: new Text("Авторизация"),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    ),
  };
}