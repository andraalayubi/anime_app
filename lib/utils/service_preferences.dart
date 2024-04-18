import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isDarkTheme = false; // Default is light theme
  bool get isDarkTheme => _isDarkTheme;

  PreferencesService() {
    loadThemePreference();
  }

  Future<void> updateTheme(bool isDark) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isDarkTheme', isDark);
    _isDarkTheme = isDark;
    notifyListeners();
  }

  Future<void> loadThemePreference() async {
    final SharedPreferences prefs = await _prefs;
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false; // Default to light theme
    notifyListeners();
  }
}