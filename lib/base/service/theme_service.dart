import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeService {
  static const String _themeKey = 'selectedTheme';

  Future<void> saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index); // Salva l'indice del tema
  }

  Future<ThemeMode> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey); // Ottieni l'indice salvato

    if (themeIndex != null) {
      return ThemeMode.values[themeIndex]; // Restituisci il tema corrispondente
    } else {
      return ThemeMode.light; // Valore predefinito se non trovato
    }
  }
}
