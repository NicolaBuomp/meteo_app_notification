import 'models.dart';

class WeatherModel {
  final Location location;
  final CurrentWeather current;
  final List<DailyForecast> forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
      forecast: (json['forecast']['forecastday'] as List)
          .map((day) => DailyForecast.fromJson(day))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
      'forecast': {
        'forecastday': forecast.map((day) => day.toJson()).toList(),
      },
    };
  }
}
