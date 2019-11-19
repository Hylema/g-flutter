import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Авторизация')),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if(input.isEmpty) return 'Provide an email';
                    },
                    decoration: InputDecoration(
                        labelText: 'Email'
                    ),
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    validator: (input) {
                      if(input.length < 6) return 'Longer password please';
                    },
                    decoration: InputDecoration(
                        labelText: 'Password'
                    ),
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: signIn,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Войти'),
                  ),
                ],
              )
          ),
        )
    );
  }

  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}