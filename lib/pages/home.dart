import 'package:flutter_app/fab_with_icons.dart';
import 'package:flutter_app/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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