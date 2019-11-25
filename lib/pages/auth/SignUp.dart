import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Регистрация')),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input) {
                        if(input.isEmpty) return 'Это поле не может быть пустым';

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

                    SizedBox(height: 20.0),

                    TextFormField(
                      validator: (input) {
                        if(input.isEmpty) return 'Это поле не может быть пустым';
                      },
                      decoration: InputDecoration(
                          labelText: 'Password'
                      ),
                      onSaved: (input) => _password = input,
                    ),

                    SizedBox(height: 20.0),

                    RaisedButton(onPressed: (){
                      if(_formKey.currentState.validate()) {
                        print('Зашел');

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Have a snack!'),
                        ));
                      }
                    }, child: Text('Зарегестрироваться'), color: Colors.blue, textColor: Colors.white),
                  ],
                )
            )
        )
    );
  }

  void signUp(context) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }catch(e){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    }
  }
}
