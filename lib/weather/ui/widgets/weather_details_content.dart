import 'package:flutter/material.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';

class WeatherDetailsContent extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailsContent({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    final todayForecast = weather.forecast.first;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.location.name}, ${weather.location.region}, ${weather.location.country}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Temperature:', '${current.temperature}°C'),
          _buildDetailRow('Feels Like:', '${current.feelsLike}°C'),
          _buildDetailRow('Condition:', current.condition.text),
          _buildDetailRow('Humidity:', '${current.humidity}%'),
          _buildDetailRow('Wind Speed:', '${current.windSpeed} km/h'),
          _buildDetailRow('UV Index:', '${current.uvIndex}'),
          _buildDetailRow('Max Temp:', '${todayForecast.maxTemp}°C'),
          _buildDetailRow('Min Temp:', '${todayForecast.minTemp}°C'),
          _buildDetailRow('Precipitation:', '${todayForecast.totalPrecip} mm'),
          _buildDetailRow('Chance of Rain:', '${todayForecast.chanceOfRain}%'),
          _buildDetailRow('Sunrise:', todayForecast.sunrise),
          _buildDetailRow('Sunset:', todayForecast.sunset),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
