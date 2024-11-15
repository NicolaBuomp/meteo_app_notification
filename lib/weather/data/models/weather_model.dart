import 'package:meteo_app_notification/weather/data/models/models.dart';

class WeatherModel {
  final String location;
  final String region;
  final String country;
  final int localtime;
  final double temperature;
  final String condition;
  final String iconUrl;
  final int humidity;
  final double windSpeed;
  final double feelsLike;
  final double uvIndex;
  final double maxTemp;
  final double minTemp;
  final double totalPrecip;
  final int chanceOfRain;
  final String sunrise;
  final String sunset;
  final double latitude;
  final double longitude;
  final List<DailyForecast> forecast;

  WeatherModel({
    required this.location,
    required this.region,
    required this.country,
    required this.localtime,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.uvIndex,
    required this.maxTemp,
    required this.minTemp,
    required this.totalPrecip,
    required this.chanceOfRain,
    required this.sunrise,
    required this.sunset,
    required this.latitude,
    required this.longitude,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location']?['name'] as String? ?? 'Unknown',
      region: json['location']?['region'] as String? ?? '',
      country: json['location']?['country'] as String? ?? '',
      localtime: json['location']?['localtime_epoch'] != null
          ? json['location']['localtime_epoch'] as int
          : 0,
      latitude: json['location']?['lat'] != null
          ? (json['location']['lat'] as num).toDouble()
          : 0.0,
      longitude: json['location']?['lon'] != null
          ? (json['location']['lon'] as num).toDouble()
          : 0.0,
      temperature: json['current']?['temp_c'] != null
          ? (json['current']['temp_c'] as num).toDouble()
          : 0.0,
      condition: json['current']?['condition']?['text'] as String? ?? 'N/A',
      iconUrl: json['current']?['condition']?['icon'] != null
          ? "https:${json['current']['condition']['icon']}"
          : '',
      humidity: json['current']?['humidity'] != null
          ? json['current']['humidity'] as int
          : 0,
      windSpeed: json['current']?['wind_kph'] != null
          ? (json['current']['wind_kph'] as num).toDouble()
          : 0.0,
      feelsLike: json['current']?['feelslike_c'] != null
          ? (json['current']['feelslike_c'] as num).toDouble()
          : 0.0,
      uvIndex: json['current']?['uv'] != null
          ? (json['current']['uv'] as num).toDouble()
          : 0.0,
      maxTemp:
          json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c'] != null
              ? (json['forecast']['forecastday'][0]['day']['maxtemp_c'] as num)
                  .toDouble()
              : 0.0,
      minTemp:
          json['forecast']?['forecastday']?[0]?['day']?['mintemp_c'] != null
              ? (json['forecast']['forecastday'][0]['day']['mintemp_c'] as num)
                  .toDouble()
              : 0.0,
      totalPrecip: json['forecast']?['forecastday']?[0]?['day']
                  ?['totalprecip_mm'] !=
              null
          ? (json['forecast']['forecastday'][0]['day']['totalprecip_mm'] as num)
              .toDouble()
          : 0.0,
      chanceOfRain: json['forecast']?['forecastday']?[0]?['day']
                  ?['daily_chance_of_rain'] !=
              null
          ? json['forecast']['forecastday'][0]['day']['daily_chance_of_rain']
              as int
          : 0,
      sunrise: json['forecast']?['forecastday']?[0]?['astro']?['sunrise']
              as String? ??
          '',
      sunset: json['forecast']?['forecastday']?[0]?['astro']?['sunset']
              as String? ??
          '',
      forecast: (json['forecast']?['forecastday'] as List<dynamic>?)
              ?.map((day) => DailyForecast.fromJson(day))
              .toList() ??
          [],
    );
  }
}
