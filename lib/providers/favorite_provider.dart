import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final Set<String> _favoriteEventTitles = {};

  bool isFavorite(String title) {
    return _favoriteEventTitles.contains(title);
  }

  void toggleFavorite(String title) {
    if (_favoriteEventTitles.contains(title)) {
      _favoriteEventTitles.remove(title);
    } else {
      _favoriteEventTitles.add(title);
    }
    notifyListeners();
  }

  Set<String> get favoriteEventTitles => _favoriteEventTitles;
}
