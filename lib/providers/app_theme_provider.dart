import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    loadTheme();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', appTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  void loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('theme');
    if (savedTheme != null) {
      appTheme = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
