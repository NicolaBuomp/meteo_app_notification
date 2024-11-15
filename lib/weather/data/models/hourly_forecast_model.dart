import 'package:meteo_app_notification/weather/data/models/models.dart';

class HourlyForecast {
  final int timeEpoch;
  final String time;
  final double tempC;
  final WeatherCondition condition;
  final int chanceOfRain;
  final bool isDayTime;

  HourlyForecast({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.condition,
    required this.chanceOfRain,
    required this.isDayTime,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
        timeEpoch: json['time_epoch'] as int? ?? 0,
        time: json['time'] as String? ?? '',
        tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
        condition: WeatherCondition.fromJson(json['condition'] ?? {}),
        chanceOfRain: json['chance_of_rain'] as int? ?? 0,
        isDayTime: json['is_day'] == 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'time_epoch': timeEpoch,
      'time': time,
      'temp_c': tempC,
      'condition': condition.toJson(),
      'chance_of_rain': chanceOfRain,
      'is_day': isDayTime ? 1 : 0,
    };
  }
}
