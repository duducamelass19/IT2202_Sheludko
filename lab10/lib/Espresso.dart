import 'ICoffee.dart';

class Espresso implements ICoffee {
  @override
  int coffeeBeans() => 10;

  @override
  int milk() => 0;

  @override
  int water() => 50;

  @override
  int cash() => 150;
}
