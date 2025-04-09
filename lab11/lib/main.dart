import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Machine.dart';
import 'CoffeeType.dart';
import 'Espresso.dart';
import 'Cappuccino.dart';
import 'Americano.dart';
import 'Latte.dart';
import 'ICoffee.dart';

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
  String message = '';
  CoffeeType selectedCoffee = CoffeeType.espresso;

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      ),
    );
  }
  void _addResources() {
    setState(() {
      machine.resources.setResource('coffeeBeans', machine.resources.coffeeBeans + 100);
      machine.resources.setResource('milk', machine.resources.milk + 100);
      machine.resources.setResource('water', machine.resources.water + 200);
    });
    _showSnackBar('Ресурсы добавлены!');
  }
  void _collectCash() {
    setState(() {
      if (machine.resources.cash > 0) {
        machine.resources.setResource('cash', 0);
        _showSnackBar('Инкассация завершена!');
      } else {
        _showSnackBar('Нет денег для инкассации.');
      }
    });
  }
  void _makeCoffee() async {
    ICoffee coffee;
    switch (selectedCoffee) {
      case CoffeeType.espresso:
        coffee = Espresso();
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        break;
      case CoffeeType.americano:
        coffee = Americano();
        break;
      case CoffeeType.latte:
        coffee = Latte();
        break;
    }

    setState(() {
      if (machine.isAvailable(coffee)) {
        machine.makingCoffee(coffee);
        _showSnackBar('${selectedCoffee.toString().split('.').last} готов!');
      } else {
        _showSnackBar('Недостаточно ресурсов!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Кофемашина',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 22,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_machine_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 20), // Увеличен верхний отступ
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Карточки ресурсов
            Column(
              children: [
                _buildResourceCard('Кофе (г):', machine.resources.coffeeBeans),
                const SizedBox(height: 12),
                _buildResourceCard('Молоко (мл):', machine.resources.milk),
                const SizedBox(height: 12),
                _buildResourceCard('Вода (мл):', machine.resources.water),
                const SizedBox(height: 12),
                _buildResourceCard('Деньги (₽):', machine.resources.cash),
              ],
            ),

            // Управление
            Column(
              children: [
                SizedBox(
                  width: double.infinity, // Растягиваем на всю ширину
                  child: _buildCoffeeTypeDropdown(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // Растягиваем на всю ширину
                  child: _buildActionButton(
                    onPressed: _addResources,
                    label: 'Добавить ресурсы',
                    icon: Icons.add,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity, // Растягиваем на всю ширину
                  child: _buildActionButton(
                    onPressed: _makeCoffee,
                    label: 'Сделать ${selectedCoffee.toString().split('.').last}',
                    icon: FontAwesomeIcons.mugHot,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity, // Растягиваем на всю ширину
                  child: _buildActionButton(
                    onPressed: _collectCash,
                    label: 'Инкассация',
                    icon: FontAwesomeIcons.moneyBill,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ],
            ),

            // Сообщение
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard(String label, int value) {
    return SizedBox(
      width: double.infinity, // Растягиваем на всю ширину
      child: Card(
        color: Colors.white.withOpacity(0.2),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const Spacer(),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeTypeDropdown() {
    return Card(
      color: Colors.white.withOpacity(0.2),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<CoffeeType>(
          value: selectedCoffee,
          onChanged: (CoffeeType? newValue) {
            setState(() {
              selectedCoffee = newValue!;
            });
          },
          items: CoffeeType.values.map((CoffeeType coffee) {
            return DropdownMenuItem<CoffeeType>(
              value: coffee,
              child: Text(
                coffee.toString().split('.').last,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          dropdownColor: Colors.white.withOpacity(0.9),
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple, size: 24),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2, // Половина ширины экрана
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26, color: Colors.deepPurple),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
    );
  }
}