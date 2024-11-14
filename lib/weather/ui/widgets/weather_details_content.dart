import 'package:flutter/material.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';

class WeatherDetailsContent extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailsContent({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.location}, ${weather.region}, ${weather.country}',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Temperature:', '${weather.temperature}°C'),
          _buildDetailRow('Feels Like:', '${weather.feelsLike}°C'),
          _buildDetailRow('Condition:', weather.condition),
          _buildDetailRow('Humidity:', '${weather.humidity}%'),
          _buildDetailRow('Wind Speed:', '${weather.windSpeed} km/h'),
          _buildDetailRow('UV Index:', '${weather.uvIndex}'),
          _buildDetailRow('Max Temp:', '${weather.maxTemp}°C'),
          _buildDetailRow('Min Temp:', '${weather.minTemp}°C'),
          _buildDetailRow('Precipitation:', '${weather.totalPrecip} mm'),
          _buildDetailRow('Chance of Rain:', '${weather.chanceOfRain}%'),
          _buildDetailRow('Sunrise:', weather.sunrise),
          _buildDetailRow('Sunset:', weather.sunset),
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
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
