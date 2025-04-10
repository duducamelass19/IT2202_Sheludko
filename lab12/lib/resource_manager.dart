import 'package:flutter/material.dart';

class ResourceManager extends ChangeNotifier {
  int coffee = 100; // в граммах
  int milk = 250;   // в мл
  int water = 500;  // в мл
  int money = 1000; // в рублях

  void addResources({int? coffee, int? milk, int? water}) {
    this.coffee += coffee ?? 0;
    this.milk += milk ?? 0;
    this.water += water ?? 0;
    notifyListeners();
  }

  void subtractResources({int? coffee, int? milk, int? water}) {
    this.coffee -= coffee ?? 0;
    this.milk -= milk ?? 0;
    this.water -= water ?? 0;
    notifyListeners();
  }

  void addMoney(int amount) {
    money += amount;
    notifyListeners();
  }

  void subtractMoney(int amount) {
    money -= amount;
    notifyListeners();
  }
}