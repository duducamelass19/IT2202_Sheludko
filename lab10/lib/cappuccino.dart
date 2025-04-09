import 'ICoffee.dart';

class Cappuccino implements ICoffee {
  @override
  int coffeeBeans() => 15;

  @override
  int milk() => 100;

  @override
  int water() => 50;

  @override
  int cash() => 200;
}
