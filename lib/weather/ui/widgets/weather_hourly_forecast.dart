import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:meteo_app_notification/weather/ui/widgets/weather_icon.dart';
import '../../data/models/hourly_forecast_model.dart';

class WeatherHourlyForecast extends StatelessWidget {
  final List<HourlyForecast> hourly;
  final int localtimeEpoch; // Orario locale in secondi
  final String timezoneId; // "Europe/London", "America/Los_Angeles", etc.
  final double hPadding;
  final double vPadding;

  const WeatherHourlyForecast({
    super.key,
    required this.hourly,
    required this.localtimeEpoch,
    required this.timezoneId,
    this.hPadding = 0.0,
    this.vPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    // Ottieni la location dal timezoneId
    final validTimezoneId = timezoneId.isNotEmpty ? timezoneId : 'UTC';
    final location = tz.getLocation(validTimezoneId);

    // Calcola l'orario corrente nel fuso orario della location
    final currentTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
      location,
      localtimeEpoch * 1000,
    );

    final filteredHourly = hourly.where((hour) {
      final hourTime = tz.TZDateTime.fromMillisecondsSinceEpoch(
        location,
        hour.timeEpoch * 1000,
      );
      return hourTime.isAfter(currentTime);
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prossime ore',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                return _buildHourlyTile(hour, location);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyTile(HourlyForecast hour, tz.Location location) {
    final time = DateFormat.Hm().format(
      tz.TZDateTime.fromMillisecondsSinceEpoch(
        location,
        hour.timeEpoch * 1000,
      ),
    );

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 4),
              WeatherIconWidget(
                conditionCode: hour.condition.code,
                isDayTime: hour.isDayTime,
                size: 20.0,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 4),
              Text(
                '${hour.tempC}°C',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
