import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/weather_model.dart';

class WeatherService {
  static const String _cacheWeatherData = 'cachedWeatherData';

  Future<void> saveWeatherData(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();

    final weatherData = jsonEncode({
      'location': weather.location,
      'region': weather.region,
      'country': weather.country,
      'localtime': weather.localtime,
      'latitude': weather.latitude,
      'longitude': weather.longitude,
      'temperature': weather.temperature,
      'condition': weather.condition,
      'iconUrl': weather.iconUrl,
      'humidity': weather.humidity,
      'windSpeed': weather.windSpeed,
      'feelsLike': weather.feelsLike,
      'uvIndex': weather.uvIndex,
      'maxTemp': weather.maxTemp,
      'minTemp': weather.minTemp,
      'totalPrecip': weather.totalPrecip,
      'chanceOfRain': weather.chanceOfRain,
      'sunrise': weather.sunrise,
      'sunset': weather.sunset,
      'forecast': weather.forecast
          .map((day) => {
                'date': day.date,
                'maxTemp': day.maxTemp,
                'minTemp': day.minTemp,
                'totalPrecip': day.totalPrecip,
                'chanceOfRain': day.chanceOfRain,
                'condition': day.condition,
                'iconUrl': day.iconUrl,
                'hourly': day.hourly
                    .map((hour) => {
                          'time': hour.time,
                          'tempC': hour.tempC,
                          'condition': hour.condition,
                          'iconUrl': hour.iconUrl,
                        })
                    .toList(),
              })
          .toList(),
    });

    await prefs.setString(_cacheWeatherData, weatherData);
  }

  Future<WeatherModel?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherData = prefs.getString(_cacheWeatherData);

    if (weatherData != null) {
      final json = jsonDecode(weatherData);
      return WeatherModel(
        location: json['location'],
        region: json['region'],
        country: json['country'],
        localtime: json['localtime'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        temperature: json['temperature'],
        condition: json['condition'],
        iconUrl: json['iconUrl'],
        humidity: json['humidity'],
        windSpeed: json['windSpeed'],
        feelsLike: json['feelsLike'],
        uvIndex: json['uvIndex'],
        maxTemp: json['maxTemp'],
        minTemp: json['minTemp'],
        totalPrecip: json['totalPrecip'],
        chanceOfRain: json['chanceOfRain'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        forecast: (json['forecast'] as List).map((day) {
          return DailyForecast(
            date: day['date'],
            maxTemp: day['maxTemp'],
            minTemp: day['minTemp'],
            totalPrecip: day['totalPrecip'],
            chanceOfRain: day['chanceOfRain'],
            condition: day['condition'],
            iconUrl: day['iconUrl'],
            hourly: (day['hourly'] as List).map((hour) {
              return HourlyForecast(
                time: hour['time'],
                tempC: hour['tempC'],
                condition: hour['condition'],
                iconUrl: hour['iconUrl'],
              );
            }).toList(),
          );
        }).toList(),
      );
    }
    return null;
  }

  Future<void> clearWeatherCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheWeatherData);
  }
}
