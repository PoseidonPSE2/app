import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/WaterSettings.dart';
import 'package:hello_worl2/pages/other/login.dart';
import 'package:hello_worl2/materialTheme/custom_theme.dart';
import 'package:hello_worl2/materialTheme/util.dart';
import 'package:hello_worl2/provider/bottleProvider.dart';
import 'package:hello_worl2/theme/theme.dart';
import 'package:hello_worl2/widgets.dart/navbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: brightness == Brightness.light ? darkMode : darkMode,
      //brightness == Brightness.light ? theme.light() : theme.dark(),
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const NavBar(),
        '/water_settings': (context) => const WaterSettings(),
      },
    );
  }
}
