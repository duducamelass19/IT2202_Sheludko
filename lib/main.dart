import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: TextStyle(color: Colors.blue),
        ),
      ),
      home: AreaCalculator(),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  String _result = '';
  String _widthErrorMessage = '';
  String _heightErrorMessage = '';

  void _calculateArea() {
    setState(() {
      _widthErrorMessage = _widthController.text.isEmpty ? 'Пожалуйста, введите ширину.' : '';
      _heightErrorMessage = _heightController.text.isEmpty ? 'Пожалуйста, введите высоту.' : '';

      if (_widthErrorMessage.isEmpty && _heightErrorMessage.isEmpty) {
        try {
          double width = double.parse(_widthController.text);
          double height = double.parse(_heightController.text);
          double area = width * height;
          _result = 'S = $width * $height = $area мм²';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Площадь успешно вычислена!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          _widthErrorMessage = 'Пожалуйста, введите числовое значение.';
          _heightErrorMessage = 'Пожалуйста, введите числовое значение.';
          _result = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор площади'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _widthController,
              decoration: InputDecoration(
                labelText: 'Ширина (мм)',
                errorText: _widthErrorMessage.isNotEmpty ? _widthErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue, // Цвет курсора
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Высота (мм)',
                errorText: _heightErrorMessage.isNotEmpty ? _heightErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue, // Цвет курсора
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateArea,
              child: Text('Вычислить'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result.isNotEmpty ? _result : 'Задайте параметры',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}