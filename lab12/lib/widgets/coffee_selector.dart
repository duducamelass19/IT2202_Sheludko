import 'package:flutter/material.dart';

class CoffeeSelectorWidget extends StatelessWidget {
  final Function(String) onCoffeeSelected;

  const CoffeeSelectorWidget({
    super.key,
    required this.onCoffeeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Выберите кофе:', style: TextStyle(fontSize: 16, color: Colors.white)),
        const SizedBox(height: 10),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildCoffeeButton('Espresso', 100),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCoffeeButton('Latte', 150),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildCoffeeButton('Americano', 120),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCoffeeButton('Cappuccino', 160),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoffeeButton(String coffeeType, int price) {
    return ElevatedButton(
      onPressed: () => onCoffeeSelected(coffeeType),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size.fromHeight(48),
      ),
      child: Text(
        '$coffeeType ($price ₽)',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}