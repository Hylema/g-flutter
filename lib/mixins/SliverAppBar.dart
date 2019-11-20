import 'package:flutter/material.dart';

func (){
  return Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
//              title: Text("hello"),
          expandedHeight: 150,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('2'),
            centerTitle: false,
            collapseMode: CollapseMode.parallax,
            background: Container(
              color: Colors.red,
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
  );
}