import 'package:flutter_app/fab_with_icons.dart';
import 'package:flutter_app/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants/toroWebAuthConst.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({this.codeUrl = ''});
  final String codeUrl;

  @override
  _MyHomePageState createState() => new _MyHomePageState(codeUrl: codeUrl);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final String codeUrl;
  _MyHomePageState({
    this.codeUrl
  });

  var _response;
  var _statusCode;

  get response{
    if(_response == null){
      http.post('https://login.microsoftonline.com/12f6ad44-d1ba-410f-97d4-6c966e38421b/oauth2/token', body: {
        ...constants,
        'code': codeUrl
      }).then((onValue) {
        response = onValue.body;
        statusCode = onValue.statusCode;
      });
    }

    return _response;
  }

  set response(newValue){
    setState(() {
      _response = newValue;
    });
  }

  get statusCode {
    return _statusCode;
  }

  set statusCode(newValue){
    setState(() {
      _statusCode = newValue;
    });
  }
  final bottomAppBarItem = [
    {
      'iconData': Icons.home,
      'text': 'Главная'
    },
    {
      'iconData': Icons.assignment,
      'text': 'Структура'
    },
    {
      'iconData': Icons.help_outline,
      'text': 'Помощь'
    },
    {
      'iconData': Icons.more_horiz,
      'text': 'Ещё'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Главная'),
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
                SizedBox(
                  height: 1000,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('РЕЗУЛЬТАТ'),
                      SizedBox(height: 5.0),
                      Text(
                        codeUrl == null ? 'Не удалось получить код авторизации' : 'Код авторизации успешно получен === CODE=$codeUrl',
                        style: codeUrl == null ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                          'Ответ запроса на получение токена === RESPONSE=$response',
                        style: _statusCode == null || _statusCode == 400 ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 5.0),
                      Text('СТАТУС КОД==========================$_statusCode'),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
        bottomNavigationBar: FABBottomAppBar(
          centerItemText: 'Новый',
          color: Colors.grey,
          selectedColor: Colors.deepOrangeAccent,
          notchedShape: CircularNotchedRectangle(),
          items: collectBottomAppBarItems(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabWithIcons(
          icons: icons,
        ),
    );
  }

  collectBottomAppBarItems(){
    List array = [];

    bottomAppBarItem.forEach((value) {
      array.add(FABBottomAppBarItem(iconData: value['iconData'], text: value['text']));
    });
    return array;
  }
}