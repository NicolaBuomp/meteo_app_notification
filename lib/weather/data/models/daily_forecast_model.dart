// lib/weather/data/models/daily_forecast_model.dart

import 'package:meteo_app_notification/weather/data/models/models.dart';

class DailyForecast {
  final String date;
  final int dateEpoch;
  final double maxTemp;
  final double minTemp;
  final double totalPrecip;
  final int chanceOfRain;
  final WeatherCondition condition;
  final List<HourlyForecast> hourly;
  final String sunrise;
  final String sunset;

  DailyForecast({
    required this.date,
    required this.dateEpoch,
    required this.maxTemp,
    required this.minTemp,
    required this.totalPrecip,
    required this.chanceOfRain,
    required this.condition,
    required this.hourly,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date'] as String? ?? '',
      dateEpoch: json['date_epoch'] as int? ?? 0,
      maxTemp: (json['day']['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      minTemp: (json['day']['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      totalPrecip: (json['day']['totalprecip_mm'] as num?)?.toDouble() ?? 0.0,
      chanceOfRain: json['day']['daily_chance_of_rain'] as int? ?? 0,
      condition: WeatherCondition.fromJson(json['day']['condition'] ?? {}),
      hourly: (json['hour'] as List<dynamic>?)
              ?.map((hour) => HourlyForecast.fromJson(hour))
              .toList() ??
          [],
      sunrise: json['astro']['sunrise'] as String? ?? '',
      sunset: json['astro']['sunset'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'date_epoch': dateEpoch,
      'day': {
        'maxtemp_c': maxTemp,
        'mintemp_c': minTemp,
        'totalprecip_mm': totalPrecip,
        'daily_chance_of_rain': chanceOfRain,
        'condition': condition.toJson(),
      },
      'hour': hourly.map((hour) => hour.toJson()).toList(),
      'astro': {
        'sunrise': sunrise,
        'sunset': sunset,
      },
    };
  }
}
