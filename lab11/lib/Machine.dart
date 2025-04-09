import 'package:flutter/material.dart';
import 'coffee_process.dart'; // Импортируем файл с асинхронными методами
import 'ICoffee.dart';
import 'Resources.dart';

class Machine {
  final Resources resources = Resources();

  Future<void> makingCoffee(ICoffee coffee) async {
    print("*-------------*");
    print("_start_");

    // Нагреваем воду
    await heatWater();
    print("_then_");
    // Завариваем кофе
    await brewCoffee();
    // Если кофе с молоком, то взбиваем молоко и смешиваем
    if (coffee.milk() > 0) {
      print("_then_");
      await frothMilk();
      print("_then_");
      await mixCoffeeAndMilk();
    }
    print("_end_");
  }

  bool isAvailable(ICoffee coffee) {
    return resources.coffeeBeans >= coffee.coffeeBeans() &&
        resources.water >= coffee.water() &&
        resources.milk >= coffee.milk();
  }
}
