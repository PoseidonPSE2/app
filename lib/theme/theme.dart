import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade200,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    tertiary: const Color(0xFF2196F3),
  ),
  scaffoldBackgroundColor: Colors.grey.shade200,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color(0xFF2196F3),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        Colors.white,
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(222, 255, 255, 255),
      foregroundColor: Colors.black),
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(97, 97, 97, 1),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color.fromRGBO(117, 117, 117, 1),
    selectedColor: Colors.grey.shade400,
  ),
  sliderTheme: SliderThemeData(
    activeTickMarkColor: Colors.grey.shade400,
    activeTrackColor: Colors.grey.shade400,
    inactiveTrackColor: Colors.black,
    thumbColor: Colors.black,
    valueIndicatorColor: Colors.black,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all<Color>(
      Colors.black,
    ),
    trackColor: WidgetStateProperty.all<Color>(
      Colors.grey.shade400,
    ),
    trackOutlineColor: WidgetStateProperty.all<Color>(
      Colors.black,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
  ),
);

//Themen für den Darkmode
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
