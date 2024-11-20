import 'package:meteo_app_notification/weather/data/models/models.dart';

class CurrentWeather {
  final double temperature;
  final WeatherCondition condition;
  final int humidity;
  final double windSpeed;
  final double feelsLike;
  final double uvIndex;
  final bool isDayTime;
  final int lastUpdated;

  CurrentWeather({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.uvIndex,
    required this.isDayTime,
    required this.lastUpdated,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: (json['last_updated_epoch'] as num?)?.toInt() ?? 0,
      condition: WeatherCondition.fromJson(json['condition'] ?? {}),
      humidity: json['humidity'] as int? ?? 0,
      windSpeed: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      uvIndex: (json['uv'] as num?)?.toDouble() ?? 0.0,
      isDayTime: json['is_day'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': temperature,
      'last_updated_epoch': lastUpdated,
      'condition': condition.toJson(),
      'humidity': humidity,
      'wind_kph': windSpeed,
      'feelslike_c': feelsLike,
      'uv': uvIndex,
      'is_day': isDayTime ? 1 : 0,
    };
  }
}
