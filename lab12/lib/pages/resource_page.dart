import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resource_manager.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    final resourceManager = Provider.of<ResourceManager>(context);
    final coffeeController = TextEditingController();
    final milkController = TextEditingController();
    final waterController = TextEditingController();

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/coffee_machine_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Resources', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70)),
                const SizedBox(height: 12),
                Text('Кофе: ${resourceManager.coffee} г', style: const TextStyle(color: Colors.white)),
                Text('Молоко: ${resourceManager.milk} мл', style: const TextStyle(color: Colors.white)),
                Text('Вода: ${resourceManager.water} мл', style: const TextStyle(color: Colors.white)),
                Text('Баланс: ${resourceManager.money} ₽', style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                const Text('Добавить ресурсы:', style: TextStyle(color: Colors.white)),
                _buildResourceField('Кофе', coffeeController),
                _buildResourceField('Молоко', milkController),
                _buildResourceField('Вода', waterController),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4), 
                        child: ElevatedButton.icon(
                          onPressed: () {
                            resourceManager.addResources(
                              coffee: int.tryParse(coffeeController.text) ?? 0,
                              milk: int.tryParse(milkController.text) ?? 0,
                              water: int.tryParse(waterController.text) ?? 0,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ресурсы добавлены!')),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Добавить'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4), 
                        child: ElevatedButton.icon(
                          onPressed: () {
                            resourceManager.subtractResources(
                              coffee: int.tryParse(coffeeController.text) ?? 0,
                              milk: int.tryParse(milkController.text) ?? 0,
                              water: int.tryParse(waterController.text) ?? 0,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ресурсы отняты!')),
                            );
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text('Отнять'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResourceField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white54),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
