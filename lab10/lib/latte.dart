import 'ICoffee.dart';

class Latte implements ICoffee {
  @override
  int coffeeBeans() => 10;

  @override
  int milk() => 250;

  @override
  int water() => 100;

  @override
  int cash() => 180;
}
