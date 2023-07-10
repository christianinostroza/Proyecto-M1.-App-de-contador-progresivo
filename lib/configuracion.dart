import 'package:flutter/material.dart';

class ConfigurationScreen extends StatefulWidget {
  final int initialIncrementAmount;

  const ConfigurationScreen({super.key, 
    required this.initialIncrementAmount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.initialIncrementAmount.toString(),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _saveConfiguration() {
    final newIncrementAmount = int.tryParse(_textEditingController.text);
    if (newIncrementAmount != null) {
      setState(() {
      });
      Navigator.pop(context, newIncrementAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Aumento del Contador:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Aumento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveConfiguration,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}