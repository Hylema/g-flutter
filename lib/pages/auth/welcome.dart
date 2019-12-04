import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/fireBaseAuth/SignIn.dart';
import 'package:flutter_app/pages/auth/toroAuth/SignIn.dart';

class WelcomePage extends StatefulWidget {
  final alert;

  WelcomePage({this.alert = 0});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Colors.white,
                constraints: BoxConstraints.expand(height: 150),
                child: Image.asset(
                  'images/welcome.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Выберите способ авторизации',
                            style: TextStyle(
                                fontSize: 24.0,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Pacifico'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange,
                                    blurRadius: 20.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                      10.0, // horizontal, move right 10
                                      10.0, // vertical, move down 10
                                    ),
                                  )
                                ]
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInFireBase(), fullscreenDialog: true));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              color: Colors.orange,
                              textColor: Colors.white,
                              minWidth: 350,
                              height: 150,
                              child: Text(
                                'FireBase',
                                style: TextStyle(
                                    fontSize: 26.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 20.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInToroWeb(), fullscreenDialog: true));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              minWidth: 350,
                              height: 150,
                              child: Text(
                                'ToroWeb',
                                style: TextStyle(
                                    fontSize: 26.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}