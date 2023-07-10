import 'package:flutter/material.dart';
import 'configuracion.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.black, // Color de fondo de la AppBar
        ),
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  int _incrementAmount = 1;
  Color? _backgroundColor = Colors.grey[200]; // Color de fondo inicial
  final Color? _originalColor = Colors.grey[200]; // Color de fondo original

  void _incrementCounter() {
    setState(() {
      _counter += _incrementAmount;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter -= _incrementAmount;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void _restoreBackgroundColor() {
    setState(() {
      _backgroundColor = _originalColor;
    });
  }

  void _openConfigurationScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfigurationScreen(
          initialIncrementAmount: _incrementAmount,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _incrementAmount = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto M1. App de contador progresivo'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: _backgroundColor, // Fondo de color dinámico
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Cambiar Fondo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _changeBackgroundColor(Colors.green),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.green, // Texto en color negro
                    ),
                    child: const Text('Green'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _restoreBackgroundColor,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: _originalColor, // Texto en color negro
                    ),
                    child: const Text('Restore'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeBackgroundColor(Colors.purple),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.purple, // Texto en color negro
                    ),
                    child: const Text('Purple'),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Contador:',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'OpenSans'),
                      ),
                      Text(
                        '$_counter',
                        style: const TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold,fontFamily: 'OpenSans'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: _decrementCounter,
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 16),
                          FloatingActionButton(
                            onPressed: _resetCounter,
                            child: const Icon(Icons.refresh),
                          ),
                          const SizedBox(width: 16),
                          FloatingActionButton(
                            onPressed: _incrementCounter,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Reloj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            _openConfigurationScreen();
          }
        },
      ),
    );
  }
}