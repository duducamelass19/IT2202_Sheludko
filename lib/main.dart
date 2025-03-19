import 'package:flutter/material.dart';

void main() => runApp(HostelApp());

class HostelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КУБГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HostelScreen(),
    );
  }
}

class HostelScreen extends StatefulWidget {
  HostelScreen({Key? key}) : super(key: key);

  @override
  _HostelScreenState createState() => _HostelScreenState();
}

class _HostelScreenState extends State<HostelScreen> {
  bool _isFavorited = false;

  // Функция для отображения сообщения
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Функция для "звонка"
  void _callPhone(String number) {
    _showMessage('Была нажата кнопка "Позвонить"');
  }

  // Функция для "открытия карт"
  void _openMap(String address) {
    _showMessage('Была нажата кнопка "Маршрут"');
  }

  // Функция для "отправки SMS"
  void _shareText(String text) {
    _showMessage('Была нажата кнопка "Поделиться"');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Общежития КУБГАУ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/hostel.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Общежитие №1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Краснодар, ул. Калинина, 13',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorited ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorited = !_isFavorited;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.phone,
                  label: 'Позвонить',
                  onPressed: () => _callPhone('+78612123456'),
                ),
                _buildActionButton(
                  icon: Icons.place,
                  label: 'Маршрут',
                  onPressed: () => _openMap('Краснодар, ул. Калинина, 13'),
                ),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Поделиться',
                  onPressed: () => _shareText('Общежитие КубГАУ, Краснодар, ул. Калинина, 13'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для кнопок действий
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          color: Colors.green,
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}