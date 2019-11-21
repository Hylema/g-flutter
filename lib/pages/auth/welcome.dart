import 'package:flutter_app/pages/auth/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/accept.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();

    print('old = ${oldValue.text}');
    print('new = ${newValue.text}');

    if (newTextLength == 1) {
      newText.write('+7 ');
      selectionIndex += 3;
    }
    if (newTextLength == 2) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 1) + ' ');
      selectionIndex += 1;
    }

    if (newTextLength >= usedSubstringIndex) newText.write(newValue.text.substring(usedSubstringIndex));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  Color colorTextButton = Colors.white54;
  bool disablePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Авторизация'),
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Colors.white,
                constraints: BoxConstraints.expand(height: 150),
                child: Image.network(
                  'https://avatars.mds.yandex.net/get-pdb/199965/32b4ec73-14a2-4550-bd6c-5a7f5f5cdd18/s1200?webp=false',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10.0),

                            TextFormField(
                              validator: (input) {
                                if(input.isEmpty) return 'Provide an email';

                                String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
                                RegExp regExp = RegExp(p);
                                if (regExp.hasMatch(input)) return null;
                                return 'Некорректный Email';
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              onChanged: (input){
                                _email = input;
                                checkInputs();
                              },
                            ),

                            SizedBox(height: 10.0),

                            TextFormField(
                              validator: (input) {
                                if(input.length < 6) return 'Пароль слишком короткий';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  color: Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      disablePassword = !disablePassword;
                                    });
                                  },
                                ),
                                hintText: 'Пароль должен иметь минимум 6 символов',
                                hintStyle: TextStyle(fontSize: 11.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              onChanged: (input){
                                _password = input;
                                checkInputs();
                              },
                              obscureText: disablePassword,
                            ),

                            SizedBox(height: 30.0),

                            GestureDetector(
                                child: Text(
                                  "или",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: () {}
                            ),
                            Divider(color: Colors.blue,),

                            SizedBox(height: 30.0),

                            TextFormField(
                              keyboardType: TextInputType.phone,
                              maxLength: 15,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                NumberTextInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                icon: Icon(Icons.phone_iphone),
                                hintText: "Mobile*",
                              ),
                            ),

                            SizedBox(height: 20.0),

                            MaterialButton(
                              onPressed: (){
                                signIn(context);
                              },
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              color: Colors.blue,
                              textColor: colorTextButton,
                              minWidth: 150,
                              child: Text('Войти'),
                            ),

                            SizedBox(height: 20.0),

                            GestureDetector(
                                child: Text(
                                  "Забыли пароль?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: () {}
                            ),

                            Divider(color: Colors.blue),

                            MaterialButton(
                              onPressed: (){
                                navigateToSignUp();
                              },
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              color: Colors.white70,
                              textColor: Colors.blue,
                              minWidth: 200,
                              child: Text('Зарегестрироваться'),
                            ),
                          ],
                        )
                    ),
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }

  void checkInputs(){
    if(_password != null && _email != null){
      setState(() {
        colorTextButton = Colors.white;
      });
    }
  }

  void signIn(context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Otp()));
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Otp()));
      }catch(e){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    }
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
  }
}
