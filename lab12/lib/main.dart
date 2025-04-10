import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Главный импорт
import 'pages/coffee_page.dart';
import 'pages/resource_page.dart';
import '../resource_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider( // Теперь должен распознаваться
      create: (context) => ResourceManager(),
      child: const CoffeeMachineApp(),
    ),
  );
}

class CoffeeMachineApp extends StatelessWidget {
  const CoffeeMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DefaultTabController(
        length: 2,
        child: MainTabScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabScreen extends StatelessWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.coffee), text: 'Coffee'),
            Tab(icon: Icon(Icons.settings), text: 'Resources'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          CoffeePage(),
          ResourcePage(),
    ],
    ),
    );
  }
}
