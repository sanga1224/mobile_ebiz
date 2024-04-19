import 'package:flutter/material.dart';
import 'package:mobile_ebiz/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // ThemeMode themeMode = ThemeMode.light;
  //
  // setThemeMode(ThemeMode newThemeMode) {
  //   themeMode = newThemeMode;
  //   saveThemeModePrefs(themeMode.toString().replaceAll("ThemeMode.", ""));
  //   notifyListeners();
  // }
  //
  // saveThemeModePrefs(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("themeMode", value);
  // }
  //
  // ThemeProvider({ThemeMode initThemeMode = ThemeMode.light}) {
  //   themeMode = initThemeMode;
  // }

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      saveThemeModePrefs("dark");
    } else {
      themeData = lightMode;
      saveThemeModePrefs("light");
    }
  }

  saveThemeModePrefs(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", value);
  }

  ThemeProvider({ThemeData? initThemeData}) {
    themeData = initThemeData!;
  }
}
