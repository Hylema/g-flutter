import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_app/state/toroWebAuthState.dart';
import 'package:flutter_app/pages/home.dart';

class SignInToroWeb extends StatefulWidget {
  @override
  _SignInToroWebState createState() => new _SignInToroWebState();
}

class _SignInToroWebState extends State<SignInToroWeb> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String code;

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          //print("onStateChanged: ${state.type} ${state.url}");

//          print('URL ===========================================================${state.url}');
//          RegExp regExp = new RegExp("code=(.*)\&");
//          this.code = regExp.firstMatch(state.url)?.group(1);
//
//          print("code $code");
//
//          if(code != null){
//            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(codeUrl: code)));
//            flutterWebviewPlugin.close();
//          };
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print('URL ===========================================================${url}');
        RegExp regExp = new RegExp("code=(.*)\&");
        this.code = regExp.firstMatch(url)?.group(1);

        print("code $code");

        if(code != null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(codeUrl: code)));
          flutterWebviewPlugin.close();
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl = 'https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/authorize?response_type=code&client_id=0cf3f177-6d32-440c-a4e2-08cc84dbc3bb&redirect_uri=https://mi-portal.azurewebsites.net&%D1%8client_secret=OLijLFc8Syld34P6%5BpAOJJIT%5B%5BRrMUM-&resource=https://metalloinvest.sharepoint.com';
    //String loginUrl = "https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/authorize?response_type=code&client_id=0cf3f177-6d32-440c-a4e2-08cc84dbc3bb&redirect_uri=https://metalloinvest.sharepoint.com/sites/portal/PortalPages/home.aspx&%D1%81lient_secret=OLijLFc8Syld34P6%5BpAOJJIT%5B%5BRrMUM-&resource=https://metalloinvest.sharepoint.com";
    //String loginUrl = "https://metalloinvest.sharepoint.com/sites/portal/PortalPages/home.aspx";
    //String loginUrl = "https://metalloinvest.sharepoint.com/sites/portal/PortalPages/home.aspx?code=AQABAAIAAACQN9QBRU3jT6bcBQLZNUj7olq6bYJ6S8yGLBPEGXi76k4Ib2NQkAFBoRrCPJuEr9-LiRx7KB4Hn5bkMfLxgl_tCNso8AJk_fmDEfzS34V1fcpXJ0jzF-Kk1MJm9QDxYsrR4Z0irLJMV8hcVLH2gqn00P-h1uahOz4RMfnuijlRNGaYE4oF5Cpb0ivFCkEx3r7W_CK60bB_2b3zOAz6uqlnrmpVisWaCPNrtL6vrDfUOOUnuRF6DcGDLNdFajMIMpb64qH0cmNCUlGpAGiX17HBiKT58jWFg3yf-47y-_UC2kjxGC7Ww7YpBnZjQ88VB1JmUTUpis1FJhixc4hkEDXEDfdOmLOBQShR3wvjqBpoH6eHpVDOkSd45SO068L0vfoVxgdF7ni7gm8-7qP5v6_NIx1nMgj--kUAQW7DNgOXuawMPsBDCAeo-AfNnD4K2UdCD8b3oYIyEPxQZoMn-iIYnwiLPsFDvnxOG73LDeFbblJ6ePoKQrymcn4nIRYXsr8iNFYDCDdOQgmJFPs4UjgYM27cuEEgtgwlWMJdYS_y-Gtp-WNBlENagY7ESUW7qaJKKMuD20GkLyvObbUiHPYVDgI2kYnMV82pO6nNqyp69bLBrZSNO_pP05mZZGa-KmsQNSRE5tUiHyvFES4I2NVOo06_-msrSBYaWP1mLjuGF-fKOZ9T87nqzMgZFzBdszAwLml9av6sE2Vj0jQGmqdfi3ufWTzy2ld3N9Q1nbKq5axleB5VngVKK-Up8so34i8gAA&session_state=752b998c-3777-4ddf-9788-4e7550ae141c";

    return new WebviewScaffold(
        url: loginUrl,
        appBar: AppBar(
          title: Text("ToroWeb"),
        )
    );
  }
}