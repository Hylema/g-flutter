import 'package:flutter_app/pages/auth/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  Color colorTextButton = Colors.white54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
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
                      onChanged: (input){
                        _email = input;
                        checkInputs();
                      },
                    ),
                    TextFormField(
                      validator: (input) {
                        if(input.length < 6) return 'Пароль слишком короткий';
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: new EdgeInsets.symmetric(vertical: 10.0),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              color: Colors.grey,
                              onPressed: () {},
                            ), // icon is 48px widget.
                          ),
                          hintText: 'Пароль должен иметь минимум 6 символов',
                          hintStyle: TextStyle(fontSize: 11.0)
                      ),
                      onChanged: (input){
                        _password = input;
                        checkInputs();
                      },
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: (){
                        signIn(context);
                      },
                      color: Colors.blue,
                      textColor: colorTextButton,
                      child: Text('Войти'),
                    ),

                    GestureDetector(
                        child: Text(
                            "Забыли пароль?",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {}
                        )
                  ],
                )
            ),
          );
        },
      ),
    );
  }

  void checkInputs(){
    print('____________________________________________');
    print(_password);
    print(_email);
    print('____________________________________________');
    if(_password != null && _email != null){
      setState(() {
        colorTextButton = Colors.white;
      });
    }
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

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
  }
}

ma(){
  decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
      border: InputBorder.none,
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0),
        child: Icon(
          Icons.search,
          color: Colors.grey,
        ), // icon is 48px widget.
      ),
      hintText: 'Search artist, genre, playlist',
      hintStyle: TextStyle(fontSize: 11.0)
  );

}