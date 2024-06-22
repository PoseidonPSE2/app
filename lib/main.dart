import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/drawer/bottle/bottle_settings.dart';
import 'package:hello_worl2/pages/home/login.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';
import 'package:hello_worl2/provider/map_provider.dart';
import 'package:hello_worl2/provider/rating_provider.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hello_worl2/theme/theme.dart';
import 'package:hello_worl2/pages/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BottleProvider()),
        ChangeNotifierProvider(create: (context) => RatingProvider()),
        ChangeNotifierProvider(create: (context) => RefillStationProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider()),
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
      theme: brightness == Brightness.light ? lightMode : darkMode,
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/water_settings': (context) => const WaterSettings(),
      },
    );
  }
}
