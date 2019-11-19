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
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input) {
                        if(input.isEmpty) return 'Provide an email';

                        String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
                        RegExp regExp = RegExp(p);
                        if (regExp.hasMatch(input)) return null;
                        return 'Некорректный Email';
                      },
                      decoration: InputDecoration(
                          labelText: 'Email'
                      ),
                      onSaved: (input) => _email = input,
                    ),
                    TextFormField(
                      validator: (input) {
                        if(input.length < 6) return 'Пароль слишком короткий';
                      },
                      decoration: InputDecoration(
                          labelText: 'Password'
                      ),
                      onSaved: (input) => _password = input,
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: (){
                        signIn(context);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Войти'),
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }

  void signIn(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }catch(e){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    }
  }
}