import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple List',
          style: TextStyle(color: Colors.white), // Белый текст
        ),
        backgroundColor: Colors.green, // Зеленый фон
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text('0000')),
          ListTile(title: Text('0001')),
          ListTile(title: Text('0010')),
        ],
      ),
    );
  }
}