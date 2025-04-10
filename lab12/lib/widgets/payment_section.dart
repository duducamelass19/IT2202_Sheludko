import 'package:flutter/material.dart';

class PaymentSectionWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onPaymentMethodSelected;

  const PaymentSectionWidget({
    super.key,
    required this.controller,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentSectionWidget> createState() => _PaymentSectionWidgetState();
}

class _PaymentSectionWidgetState extends State<PaymentSectionWidget> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          style: const TextStyle(color: Colors.white), // Белый цвет текста
          decoration: InputDecoration(
            hintText: 'Введите сумму',
            hintStyle: const TextStyle(color: Colors.white54), // Светло-серый для подсказки
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54), // Белая рамка
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Белая рамка при фокусе
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedPaymentMethod = 'наличные';
                  });
                  widget.onPaymentMethodSelected('наличные');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedPaymentMethod == 'наличные'
                      ? Colors.green
                      : Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Наличные'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedPaymentMethod = 'безналичные';
                  });
                  widget.onPaymentMethodSelected('безналичные');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedPaymentMethod == 'безналичные'
                      ? Colors.green
                      : Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Карта'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}