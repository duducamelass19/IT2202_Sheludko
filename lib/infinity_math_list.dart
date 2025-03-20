import 'package:flutter/material.dart';

class InfinityMathList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Infinity Math List',
          style: TextStyle(color: Colors.white), // Белый текст
        ),
        backgroundColor: Colors.green, // Зеленый фон
      ),
    body: ListView.builder(
    itemBuilder: (context, index) {
    BigInt result = BigInt.from(2).pow(index);
    return ListTile(
    title: Text('2^$index = $result'),
    );
    },
    ),
    );
  }
}