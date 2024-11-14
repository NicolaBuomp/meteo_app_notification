import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';

class WeatherForecast extends StatelessWidget {
  final List<DailyForecast> forecast;

  const WeatherForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    // Ottieni la data attuale senza il timestamp dell'ora.
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Filtra la forecast per rimuovere il giorno corrente.
    final filteredForecast = forecast.where((day) {
      final forecastDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.fromMillisecondsSinceEpoch(day.date * 1000));
      return forecastDate != today;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nei prossimi tre giorni',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredForecast.length,
            itemBuilder: (context, index) {
              final day = filteredForecast[index];
              return _buildForecastTile(day);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForecastTile(DailyForecast day) {
    String formatDate(int timestamp) {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('EEEE').format(date); // Es. "Thursday, 14 Nov"
    }

    return Card(
      elevation: 0,
      color: Colors.grey[800],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.network(
          day.iconUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, color: Colors.grey, size: 50);
          },
        ),
        title: Text(
          formatDate(day.date),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          day.condition,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Max: ${day.maxTemp}°C',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Min: ${day.minTemp}°C',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
