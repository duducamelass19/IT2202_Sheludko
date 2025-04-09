import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Machine.dart';

void main() {
  runApp(const CoffeeMachineApp());
}

class CoffeeMachineApp extends StatelessWidget {
  const CoffeeMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CoffeeMachineScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoffeeMachineScreen extends StatefulWidget {
  const CoffeeMachineScreen({super.key});

  @override
  State<CoffeeMachineScreen> createState() => _CoffeeMachineScreenState();
}

class _CoffeeMachineScreenState extends State<CoffeeMachineScreen> {
  final Machine machine = Machine();

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  void _addResources() {
    setState(() {
      machine.coffeeBeans += 100;
      machine.milk += 100;
      machine.water += 200;
    });
    _showMessage('Ресурсы добавлены!');
  }

  void _makeCoffee() {
    setState(() {
      if (machine.isAvailable()) {
        machine.makingCoffee();
        _showMessage('Кофе готов! Выручка ${machine.coffeePrice}₽');
      } else {
        _showMessage('Недостаточно ресурсов!');
      }
    });
  }

  void _collectCash() {
    setState(() {
      if (machine.cash > 0) {
        machine.collectCash();
        _showMessage('Инкассировано!');
      } else {
        _showMessage('Нет денег для инкассации.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Кофемашина', style: TextStyle(color: Colors.deepPurple)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_machine_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            _buildResourceCard('Кофе (г):', machine.coffeeBeans),
            _buildResourceCard('Молоко (мл):', machine.milk),
            _buildResourceCard('Вода (мл):', machine.water),
            _buildResourceCard('Деньги (₽):', machine.cash),
            const SizedBox(height: 20),
            _buildFullWidthButton(
              onPressed: _addResources,
              label: 'Добавить ресурсы',
              icon: Icons.add,
            ),
            const SizedBox(height: 10),
            _buildFullWidthButton(
              onPressed: _makeCoffee,
              label: 'Сделать эспрессо',
              icon: FontAwesomeIcons.mugHot,
            ),
            const SizedBox(height: 10),
            _buildFullWidthButton(
              onPressed: _collectCash,
              label: 'Инкассация',
              icon: FontAwesomeIcons.moneyBill,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard(String label, int value) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        trailing: Text(
          '$value',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Widget _buildFullWidthButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26, color: Colors.deepPurple),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 3,
        ),
      ),
    );
  }
}
