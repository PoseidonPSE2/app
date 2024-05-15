import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/settings.dart';
import '../pages/map.dart'; // Import each screen file
import '../pages/station.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0; // Track the current selected index in navbar

  final List<Widget> _screens = [
    const MapScreen(), // List of screens to navigate between
    const RefillScreen(),
    const SettingsScreen(),
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
        title: const Text('Refill'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
