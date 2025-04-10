import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/resource_card.dart';
import '../widgets/coffee_selector.dart';
import '../widgets/payment_section.dart';
import '../async_tasks.dart';
import '../resource_manager.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final TextEditingController _paymentController = TextEditingController();
  String _message = '';
  String? _paymentMethod;
  String? _selectedCoffee;

  final Map<String, int> _coffeePrices = {
    'Espresso': 100,
    'Latte': 150,
    'Americano': 120,
    'Cappuccino': 160,
  };

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        behavior: SnackBarBehavior.fixed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _makeCoffee(String coffeeType) async {
    final resourceManager = Provider.of<ResourceManager>(context, listen: false);

    if (_paymentMethod == null) {
      _showSnackBar('Выберите способ оплаты!');
      return;
    }

    final enteredAmount = int.tryParse(_paymentController.text) ?? 0;
    final requiredAmount = _coffeePrices[coffeeType] ?? 0;

    if (enteredAmount < requiredAmount) {
      _showSnackBar('Недостаточно средств! Нужно $requiredAmount ₽');
      return;
    }

    // Проверка ресурсов
    if (resourceManager.water <100 && resourceManager.coffee <10 && ((coffeeType == 'Latte' || coffeeType == 'Cappuccino') && resourceManager.milk < 50)){
      _showSnackBar('Недостаточно ингредиентов!');
      return;
    }
    if (resourceManager.water <100 && resourceManager.coffee <10){
      _showSnackBar('Недостаточно воды и кофе!');
      return;
    }
    if (resourceManager.water <100 && ((coffeeType == 'Latte' || coffeeType == 'Cappuccino') && resourceManager.milk < 50)){
      _showSnackBar('Недостаточно воды и молока!');
      return;
    }
    if (resourceManager.coffee <10 && ((coffeeType == 'Latte' || coffeeType == 'Cappuccino') && resourceManager.milk < 50)){
      _showSnackBar('Недостаточно воды и кофе!');
      return;
    }
    if (resourceManager.water < 100) {
      _showSnackBar('Недостаточно воды!');
      return;
    }
    if (resourceManager.coffee < 10) {
      _showSnackBar('Недостаточно кофе!');
      return;
    }
    if ((coffeeType == 'Latte' || coffeeType == 'Cappuccino') && resourceManager.milk < 50) {
      _showSnackBar('Недостаточно молока!');
      return;
    }

    setState(() {
      _selectedCoffee = coffeeType;
      _message = 'Готовим $coffeeType...';
    });

    // Клиент платит - увеличиваем баланс
    resourceManager.addMoney(requiredAmount);
    _showSnackBar('Оплата $_paymentMethod. Готовим $coffeeType...');

    try {
      switch (coffeeType) {
        case 'Espresso':
          await heatWater();
          await brewCoffee();
          resourceManager.subtractResources(water: 100, coffee: 10);
          break;
        case 'Latte':
          await heatWater();
          await brewCoffee();
          await frothMilk();
          await mixCoffeeAndMilk();
          resourceManager.subtractResources(water: 100, coffee: 10, milk: 50);
          break;
        case 'Americano':
          await heatWater();
          await brewCoffee();
          resourceManager.subtractResources(water: 150, coffee: 10);
          break;
        case 'Cappuccino':
          await heatWater();
          await brewCoffee();
          await frothMilk();
          await mixCoffeeAndMilk();
          resourceManager.subtractResources(water: 100, coffee: 10, milk: 60);
          break;
      }

      _showSnackBar('$coffeeType готов! Наслаждайтесь!');
      setState(() {
        _message = '$coffeeType готов!';
      });
    } catch (e) {
      _showSnackBar('Ошибка при приготовлении кофе: $e');
      // При ошибке возвращаем деньги клиенту (вычитаем из баланса)
      resourceManager.subtractMoney(requiredAmount);
    }
  }

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/coffee_machine_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const ResourceCard(),
                const SizedBox(height: 20),
                const Text(
                  'Кофемашина',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                PaymentSectionWidget(
                  controller: _paymentController,
                  onPaymentMethodSelected: (method) {
                    setState(() {
                      _paymentMethod = method;
                    });
                    _showSnackBar('Выбрана оплата $method');
                  },
                ),
                const SizedBox(height: 20),
                if (_message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      _message,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                CoffeeSelectorWidget(
                  onCoffeeSelected: _makeCoffee,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}