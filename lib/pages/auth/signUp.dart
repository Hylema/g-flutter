import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();

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
                        return 'Это не E-mail';
                      },
                      decoration: InputDecoration(
                          labelText: 'Email'
                      ),
                    ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      validator: (input) {
                        if(input.isEmpty) return 'Это поле не может быть пустым';
                      },
                      decoration: InputDecoration(
                          labelText: 'Password'
                      ),
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
}
