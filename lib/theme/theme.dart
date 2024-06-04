import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
  scaffoldBackgroundColor: Colors.grey.shade300,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color.fromARGB(255, 19, 179, 253),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(97, 97, 97, 1),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color(0xff1c3845),
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade400,
    tertiary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.grey.shade600,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color(0xff1c3845),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color.fromRGBO(117, 117, 117, 1),
    selectedColor: Color(0xff1c3845),
  ),
  sliderTheme: const SliderThemeData(
    activeTickMarkColor: Color(0xff1c3845),
    activeTrackColor: Color(0xff1c3845),
    inactiveTrackColor: Colors.white,
    thumbColor: Colors.white,
    valueIndicatorColor: Colors.white,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all<Color>(
      Colors.white,
    ),
    trackColor: WidgetStateProperty.all<Color>(
      const Color(0xff1c3845),
    ),
    trackOutlineColor: WidgetStateProperty.all<Color>(
      Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
);
