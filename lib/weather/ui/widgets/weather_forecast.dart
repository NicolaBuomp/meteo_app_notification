import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_icon.dart';
import '../../data/models/daily_forecast_model.dart';

class WeatherForecast extends StatelessWidget {
  final List<DailyForecast> forecast;

  const WeatherForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    // Ottieni la data attuale senza il timestamp dell'ora.
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Filtra la forecast per rimuovere il giorno corrente.
    final filteredForecast = forecast.where((day) {
      return day.date != today;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nei prossimi giorni',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    String formatDate(String dateString) {
      final date = DateTime.parse(dateString);
      return DateFormat('EEEE').format(date);
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: WeatherIconWidget(
          conditionCode: day.condition.code,
          isDayTime: true,
          size: 35.0,
          color: Colors.blueGrey,
        ),
        title: Text(
          formatDate(day.date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          day.condition.text,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Max: ${day.maxTemp}°C',
            ),
            Text(
              'Min: ${day.minTemp}°C',
            ),
          ],
        ),
      ),
    );
  }
}
