import 'package:meteo_app_notification/weather/data/models/models.dart';

class DailyForecast {
  final int date;
  final double maxTemp;
  final double minTemp;
  final double totalPrecip;
  final int chanceOfRain;
  final String condition;
  final String iconUrl;
  final List<HourlyForecast> hourly;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.totalPrecip,
    required this.chanceOfRain,
    required this.condition,
    required this.iconUrl,
    required this.hourly,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date_epoch'] != null ? json['date_epoch'] as int : 0,
      maxTemp: json['day']?['maxtemp_c'] != null
          ? (json['day']['maxtemp_c'] as num).toDouble()
          : 0.0,
      minTemp: json['day']?['mintemp_c'] != null
          ? (json['day']['mintemp_c'] as num).toDouble()
          : 0.0,
      totalPrecip: json['day']?['totalprecip_mm'] != null
          ? (json['day']['totalprecip_mm'] as num).toDouble()
          : 0.0,
      chanceOfRain: json['day']?['daily_chance_of_rain'] != null
          ? json['day']['daily_chance_of_rain'] as int
          : 0,
      condition: json['day']?['condition']?['text'] as String? ?? 'N/A',
      iconUrl: json['day']?['condition']?['icon'] != null
          ? "https:${json['day']['condition']['icon']}"
          : '',
      hourly: (json['hour'] as List<dynamic>?)
              ?.map((hour) => HourlyForecast.fromJson(hour))
              .toList() ??
          [],
    );
  }
}
