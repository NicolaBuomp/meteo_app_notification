import 'package:flutter/material.dart';
import 'weather_info.dart';
import 'weather_forecast.dart';
import 'weather_hourly_forecast.dart';
import '../../data/models/weather_model.dart';

class WeatherContent extends StatelessWidget {
  final WeatherModel weather;

  const WeatherContent({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WeatherInfo(weather: weather),
          WeatherHourlyForecast(
            hourly: weather.forecast.first.hourly,
            localtimeEpoch: weather.location.localtimeEpoch,
          ),
          WeatherForecast(forecast: weather.forecast),
        ],
      ),
    );
  }
}
