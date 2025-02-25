import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(0, 84, 166, 1),
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme(
    primary: const Color.fromRGBO(0, 84, 166, 1),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.white70,
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: const Color.fromRGBO(0, 84, 166, 1),
    outline: Colors.black.withValues(alpha: 0.6),
    primaryContainer: const Color.fromRGBO(0, 84, 166, 1),
  ),
  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      color: Color.fromRGBO(0, 84, 166, 1),
      fontSize: 50,
      fontWeight: FontWeight.w800,
    ),
    headlineSmall: TextStyle(
      color: Colors.white.withValues(alpha: 1.0),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Colors.black.withValues(alpha: 1.0),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: Colors.black.withValues(alpha: 0.8),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: Colors.black.withValues(alpha: 0.6),
      fontSize: 15,
    ),
    labelLarge: const TextStyle(
      color: Color.fromRGBO(0, 84, 166, 1),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    labelMedium: const TextStyle(
      color: Color.fromRGBO(0, 84, 166, 1),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: const TextStyle(
      color: Color.fromRGBO(0, 84, 166, 1),
      fontSize: 15,
    ),
    bodySmall: TextStyle(
      color: Colors.black.withValues(alpha: 1.0),
      fontSize: 14,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(0, 84, 166, 1),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color.fromRGBO(0, 84, 166, 1),
    unselectedItemColor: Colors.black,
  ),
  cardColor: const Color(0xFFF4EDDB),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(0, 84, 166, 1),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: const Color.fromRGBO(0, 84, 166, 1).withValues(alpha: 0.8),
      fontSize: 15,
    ),
    enabledBorder: OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
      borderSide:
          BorderSide(color: Colors.black.withValues(alpha: 0.8), width: 0.0),
    ),
    border: const OutlineInputBorder(),
  ),
);

ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(66, 66, 66, 0.8),
    titleTextStyle: TextStyle(
        color:
            Color.fromRGBO(61, 129, 197, 1) //Color.fromARGB(255, 247, 54, 54),
        ),
  ),
  colorScheme: ColorScheme(
    primary: Colors.white70,
    onPrimary: Colors.black,
    secondary: Colors.white70,
    onSecondary: Colors.black,
    brightness: Brightness.dark,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.black,
    onSurface: Colors.white70,
    outline: Colors.white.withValues(alpha: 0.6),
    primaryContainer: Colors.white70,
  ),
  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      color: Color.fromRGBO(61, 129, 197, 1),
      fontSize: 50,
      fontWeight: FontWeight.w800,
    ),
    headlineSmall: TextStyle(
      color: Colors.white.withValues(alpha: 1.0),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Colors.white.withValues(alpha: 1.0),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: Colors.white.withValues(alpha: 0.9),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: Colors.white.withValues(alpha: 0.8),
      fontSize: 15,
    ),
    //Snack bar button(action) text
    labelLarge: TextStyle(
      color: Colors.white.withValues(alpha: 1.0),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    labelMedium: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    //Snack bar message
    labelSmall: const TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    bodySmall: TextStyle(
      color: Colors.white.withValues(alpha: 1.0),
      fontSize: 14,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white70,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(41, 41, 41, 1),
    selectedItemColor: Color.fromRGBO(61, 129, 197, 1),
    unselectedItemColor: Colors.white,
  ),
  cardColor: const Color.fromRGBO(66, 66, 66, 0.8),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(66, 66, 66, 0.8),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white.withValues(alpha: 0.8),
      fontSize: 15,
    ),
    enabledBorder: OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
      borderSide:
          BorderSide(color: Colors.white.withValues(alpha: 0.8), width: 0.0),
    ),
    border: const OutlineInputBorder(),
  ),
);
