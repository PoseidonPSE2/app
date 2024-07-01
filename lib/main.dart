import 'package:flutter/material.dart';
import 'package:refill/pages/drawer/bottle/bottle_settings.dart';
import 'package:refill/pages/home/login.dart';
import 'package:refill/provider/bottle_provider.dart';
import 'package:refill/provider/map_provider.dart';
import 'package:refill/provider/rating_provider.dart';
import 'package:refill/provider/refillstation_provider.dart';
import 'package:refill/provider/user_provider.dart';
import 'package:refill/theme/theme.dart';
import 'package:refill/pages/home/home.dart';
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
      theme: brightness == Brightness.light ? lightMode : lightMode,
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/water_settings': (context) => const WaterSettings(),
      },
    );
  }
}
