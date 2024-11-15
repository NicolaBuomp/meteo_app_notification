import 'dart:convert';
import 'package:meteo_app_notification/weather/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherService {
  static const String _cacheWeatherData = 'cachedWeatherData';

  Future<void> saveWeatherData(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();

    final weatherData = jsonEncode(weather.toJson());

    await prefs.setString(_cacheWeatherData, weatherData);
  }

  Future<WeatherModel?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherData = prefs.getString(_cacheWeatherData);

    if (weatherData != null) {
      final json = jsonDecode(weatherData);

      return WeatherModel.fromJson(json);
    }
    return null;
  }

  Future<void> clearWeatherCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheWeatherData);
  }
}
