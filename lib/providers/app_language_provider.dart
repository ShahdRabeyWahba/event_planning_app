import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  AppLanguageProvider() {
    loadLanguage();
  }

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', appLanguage);
  }

  void loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      appLanguage = savedLanguage;
      notifyListeners();
    }
  }
}