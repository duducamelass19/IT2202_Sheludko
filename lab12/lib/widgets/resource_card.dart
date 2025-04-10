import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resource_manager.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final resourceManager = Provider.of<ResourceManager>(context);

    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Ресурсы', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8, width: double.infinity),
            Text('Кофе: ${resourceManager.coffee} г'),
            Text('Молоко: ${resourceManager.milk} мл'),
            Text('Вода: ${resourceManager.water} мл'),
            Text('Баланс: ${resourceManager.money} ₽'),
          ],
        ),
      ),
    );
  }
}