import 'package:flutter/material.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherHourlyForecast extends StatelessWidget {
  final List<HourlyForecast> hourly;
  final int localtime;

  const WeatherHourlyForecast({
    super.key,
    required this.hourly,
    required this.localtime,
  });

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.fromMillisecondsSinceEpoch(localtime * 1000);
    final filteredHourly = hourly.where((hour) {
      final hourTime = DateTime.fromMillisecondsSinceEpoch(
          hour.time * 1000); // Usa int.parse per convertire la stringa
      return hourTime.isAfter(currentTime);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prossime ore',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredHourly.length,
              itemBuilder: (context, index) {
                final hour = filteredHourly[index];
                return _buildHourlyTile(hour);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyTile(HourlyForecast hour) {
    final time = DateFormat.Hm()
        .format(DateTime.fromMillisecondsSinceEpoch(hour.time * 1000));

    return Card(
      elevation: 0,
      color: Colors.grey[800],
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 60, // Imposta una larghezza fissa
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              const SizedBox(height: 4),
              Image.network(
                hour.iconUrl,
                width: 30, // Riduci dimensione immagine
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, color: Colors.grey);
                },
              ),
              const SizedBox(height: 4),
              Text(
                '${hour.tempC}°C',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12), // Riduci dimensione testo
              ),
            ],
          ),
        ),
      ),
    );
  }
}
