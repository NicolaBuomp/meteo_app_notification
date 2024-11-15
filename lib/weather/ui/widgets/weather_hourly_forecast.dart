import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_icon.dart';
import '../../data/models/hourly_forecast_model.dart';

class WeatherHourlyForecast extends StatelessWidget {
  final List<HourlyForecast> hourly;
  final int localtimeEpoch;

  const WeatherHourlyForecast({
    super.key,
    required this.hourly,
    required this.localtimeEpoch,
  });

  @override
  Widget build(BuildContext context) {
    final currentTime =
        DateTime.fromMillisecondsSinceEpoch(localtimeEpoch * 1000);
    final filteredHourly = hourly.where((hour) {
      final hourTime =
          DateTime.fromMillisecondsSinceEpoch(hour.timeEpoch * 1000);
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
        .format(DateTime.fromMillisecondsSinceEpoch(hour.timeEpoch * 1000));

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
