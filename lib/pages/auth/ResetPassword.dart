import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResetPasswordState();
}

class ResetPasswordState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Восстановление пароля')),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Builder(
                builder: (BuildContext context) {
                  return Container(
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
                              onChanged: (input) => _email = input,
                            ),

                            RaisedButton(
                                onPressed: (){
                                  resetPassword(context);
                                },
                                child: Text('Восстановать пароль'),
                                color: Colors.blue,
                                textColor: Colors.white
                            ),
                          ],
                        )
                    ),
                  );
                }
            )
        )
    );
  }

  void resetPassword(context) async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Сообщение успешно отправленно по адресу - ${_email}', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));
      } catch(e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    }
  }
}