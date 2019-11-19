import 'package:flutter_app/pages/auth/signIn.dart';
import 'package:flutter_app/pages/auth/signUp.dart';
import 'package:flutter_app/pages/auth/welcome.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter/material.dart';

routes(){
  return {
    '/': (BuildContext context) => WelcomePage(),
    '/signIn': (BuildContext context) => SignIn(),
    '/signUp': (BuildContext context) => SignUp(),
    '/home': (BuildContext context) => HomePage(),
  };
}