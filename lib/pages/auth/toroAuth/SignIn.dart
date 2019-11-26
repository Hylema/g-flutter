import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SignInToroWeb extends StatefulWidget {
  @override
  _SignInToroWebState createState() => new _SignInToroWebState();
}

class _SignInToroWebState extends State<SignInToroWeb> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String token;

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
          print("onStateChanged: ${state.type} ${state.url}");
        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl = "https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/authorize?response_type=code&client_id=0cf3f177-6d32-440c-a4e2-08cc84dbc3bb&redirect_uri=https://metalloinvest.sharepoint.com/sites/portal/PortalPages/home.aspx&%D1%81lient_secret=OLijLFc8Syld34P6%5BpAOJJIT%5B%5BRrMUM-&resource=https://metalloinvest.sharepoint.com";

    return new WebviewScaffold(
        url: loginUrl,
        appBar: AppBar(
          title: Text("ToroWeb"),
        ));
  }
}