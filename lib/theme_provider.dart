import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notifie toutes les pages du changement
  }

  ThemeData get currentTheme => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}
