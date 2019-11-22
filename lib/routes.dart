import 'package:flutter_app/pages/auth/SignUp.dart';
import 'package:flutter_app/pages/auth/Welcome.dart';
import 'package:flutter_app/pages/accept.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter/material.dart';

routes(){
  return {
    '/': (BuildContext context) => WelcomePage(),
    '/signUp': (BuildContext context) => SignUp(),
    '/home': (BuildContext context) => HomePage(),
    '/accept': (BuildContext context) => Otp(),
  };
}