import 'ICoffee.dart';

class Americano implements ICoffee {
  @override
  int coffeeBeans() => 10;

  @override
  int milk() => 0;

  @override
  int water() => 150;

  @override
  int cash() => 100;
}
