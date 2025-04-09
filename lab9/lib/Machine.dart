class Machine {
  int coffeeBeans = 0;
  int milk = 0;
  int water = 0;
  int cash = 0;

  final int coffeePrice = 150;

  bool isAvailable() {
    return coffeeBeans >= 20 && milk >= 50 && water >= 100;
  }

  void makingCoffee() {
    coffeeBeans -= 20;
    milk -= 50;
    water -= 100;
    cash += coffeePrice;
  }

  void collectCash() {
    cash = 0;
  }
}
