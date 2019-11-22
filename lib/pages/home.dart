import 'package:flutter_app/fab_with_icons.dart';
import 'package:flutter_app/fab_bottom_app_bar.dart';
import 'package:flutter_app/layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Главная'),
      color: Colors.grey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  @override
  Widget build(BuildContext context) {
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
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Главная'),
          FABBottomAppBarItem(iconData: Icons.assignment, text: 'Структура'),
          FABBottomAppBarItem(iconData: Icons.help_outline, text: 'Помощь'),
          FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'Ещё'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];

    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.remove),
        elevation: 2.0,
      ),
    );
  }
}