import 'package:flutter/material.dart';
import 'package:hello_worl2/ui/screens/settings.dart';
import 'map.dart'; // Import each screen file
import 'station.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // Set the initial screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Track the current selected index in navbar

  final List<Widget> _screens = [
    MapScreen(), // List of screens to navigate between
    RefillScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Refill', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.lightBlueAccent),
      //backgroundColor: Color.fromRGBO(80,153,183,255),

      body: _screens[_currentIndex], // Display current screen
      bottomNavigationBar: BottomNavigationBar(
        // Persistent navbar
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Refill',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }
}

// Individual screens (replace content with your desired UI)
