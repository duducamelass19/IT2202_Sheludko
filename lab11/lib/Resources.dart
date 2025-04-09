class Resources {
  int coffeeBeans = 1000;
  int milk = 1000;
  int water = 1000;
  int cash = 1000;

  int getResource(String resource) {
    switch (resource) {
      case 'coffeeBeans':
        return coffeeBeans;
      case 'milk':
        return milk;
      case 'water':
        return water;
      case 'cash':
        return cash;
      default:
        return 0;
    }
  }

  void setResource(String resource, int value) {
    switch (resource) {
      case 'coffeeBeans':
        coffeeBeans = value;
        break;
      case 'milk':
        milk = value;
        break;
      case 'water':
        water = value;
        break;
      case 'cash':
        cash = value;
        break;
    }
  }
}