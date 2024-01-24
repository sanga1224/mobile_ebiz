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
    background: Colors.white,
    onBackground: const Color.fromRGBO(0, 84, 166, 1),
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: Colors.black,
    outline: Colors.black.withOpacity(0.6),
    primaryContainer: const Color.fromRGBO(0, 84, 166, 1),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.black.withOpacity(1.0),
      fontSize: 30,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: Colors.black.withOpacity(1.0),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      color: Colors.black.withOpacity(1.0),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    labelMedium: TextStyle(
      color: Colors.black.withOpacity(1.0),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      color: Colors.black.withOpacity(0.6),
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
    background: Colors.black,
    onBackground: Colors.white70,
    brightness: Brightness.dark,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.black,
    onSurface: Colors.white,
    outline: Colors.white.withOpacity(0.6),
    primaryContainer: Colors.white70,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.white.withOpacity(1.0),
      fontSize: 30,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      color: Colors.white.withOpacity(1.0),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontSize: 16,
    ),
    //Snack bar button(action) text
    labelLarge: TextStyle(
      color: Colors.white.withOpacity(1.0),
      fontSize: 28,
      fontWeight: FontWeight.w800,
    ),
    labelMedium: TextStyle(
      color: Colors.black.withOpacity(1.0),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    //Snack bar message
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
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
);
