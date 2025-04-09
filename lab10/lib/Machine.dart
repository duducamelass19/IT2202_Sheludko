import 'Resources.dart';
import 'ICoffee.dart';

class Machine {
  final Resources resources = Resources();

  bool isAvailable(ICoffee coffee) {
    return resources.coffeeBeans >= coffee.coffeeBeans() &&
        resources.milk >= coffee.milk() &&
        resources.water >= coffee.water();
  }

  void makingCoffee(ICoffee coffee) {
    if (isAvailable(coffee)) {
      resources.setResource('coffeeBeans', resources.coffeeBeans - coffee.coffeeBeans());
      resources.setResource('milk', resources.milk - coffee.milk());
      resources.setResource('water', resources.water - coffee.water());
      resources.setResource('cash', resources.cash + coffee.cash());
    }
  }
}