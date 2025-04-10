
Future<void> heatWater() async {
  print('start_process: water');
  await Future.delayed(const Duration(seconds: 3));
  print('done_process: water');
}

Future<void> brewCoffee() async {
  print('start_process: espresso');
  await Future.delayed(const Duration(seconds: 5));
  print('done_process: coffee with water');
}

Future<void> frothMilk() async {
  print('start_process: milk');
  await Future.delayed(const Duration(seconds: 5));
  print('done_process: milk');
}

Future<void> mixCoffeeAndMilk() async {
  print('start_process: mixing coffee and milk');
  await Future.delayed(const Duration(seconds: 3));
  print('done_process: coffee with milk');
}
