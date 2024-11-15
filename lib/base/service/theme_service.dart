import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeService {
  static const String _themeKey = 'selectedTheme';

  Future<void> saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
  }

  Future<ThemeMode> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    } else {
      return ThemeMode.light;
    }
  }
}
