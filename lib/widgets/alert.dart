import 'package:flutter/material.dart';

String _warning;

Widget showAlert() {
  if (_warning != null) {
    return Container(
      color: Colors.amberAccent,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
            child: Text(
              _warning,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
//                setState(() {
//                  _warning = null;
//                });
              },
            ),
          )
        ],
      ),
    );
  }
  return SizedBox(
    height: 0,
  );
}