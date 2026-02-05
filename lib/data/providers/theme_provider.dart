import 'package:flutter/material.dart';

// provider that controls light and dark theme
class ThemeProvider extends ChangeNotifier {
  // current theme state
  bool isDarkMode = false;

  // return theme mode based on current state
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // switch between dark and light mode
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
