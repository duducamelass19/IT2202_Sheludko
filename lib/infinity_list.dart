import 'package:flutter/material.dart';

class InfinityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Infinity List',
          style: TextStyle(color: Colors.white), // Белый текст
        ),
        backgroundColor: Colors.green, // Зеленый фон
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Строка $index'),
          );
        },
      ),
    );
  }
}