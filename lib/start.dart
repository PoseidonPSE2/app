import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/settings/SettingsScreen.dart';
import 'package:hello_worl2/pages/waterSettings.dart';
import 'package:hello_worl2/pages/other/login.dart';
import 'package:hello_worl2/provider/bottleProvider.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:hello_worl2/theme/theme.dart';
import 'package:hello_worl2/widgets.dart/navbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BottleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return MaterialApp(
      theme: brightness == Brightness.light ? darkMode : darkMode,
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const NavBar(),
        '/water_settings': (context) => const WaterSettings(),
        '/test': (context) => UserListScreen(),
      },
    );
  }
}
