import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  //todo: data
  ThemeMode appTheme = ThemeMode.light;
  ThemeMode ? theme;

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    theme = appTheme;
    notifyListeners();
  }

  bool isDarkMode(){
    return appTheme == ThemeMode.dark;
  }
}
