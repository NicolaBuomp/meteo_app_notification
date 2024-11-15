// lib/weather/services/weather_service.dart

import 'dart:convert';
import 'package:meteo_app_notification/weather/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherService {
  static const String _cacheWeatherData = 'cachedWeatherData';

  Future<void> saveWeatherData(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();

    // Utilizza il metodo toJson() del modello per serializzare i dati
    final weatherData = jsonEncode(weather.toJson());

    await prefs.setString(_cacheWeatherData, weatherData);
  }

  Future<WeatherModel?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherData = prefs.getString(_cacheWeatherData);

    if (weatherData != null) {
      final json = jsonDecode(weatherData);

      // Utilizza il metodo fromJson() del modello per deserializzare i dati
      return WeatherModel.fromJson(json);
    }
    return null;
  }

  Future<void> clearWeatherCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheWeatherData);
  }
}
