import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/login.dart';
import 'package:hello_worl2/materialTheme/custom_theme.dart';
import 'package:hello_worl2/materialTheme/util.dart';
import 'package:hello_worl2/theme/theme.dart';
import 'package:hello_worl2/widgets.dart/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: brightness == Brightness.light ? lightMode : lightMode,
      //brightness == Brightness.light ? theme.light() : theme.dark(),
      home: Login(),
      routes: {
        '/home': (context) => const NavBar(),
      },
    );
  }
}
