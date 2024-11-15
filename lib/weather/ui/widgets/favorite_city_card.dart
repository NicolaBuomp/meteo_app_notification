import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/data/models/city_info_model.dart';
import 'package:meteo_app_notification/weather/di/weather_provider.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_city_actions.dart';

class FavoriteCityCard extends ConsumerWidget {
  final CityInfo city;
  final VoidCallback onTap;

  const FavoriteCityCard({
    super.key,
    required this.city,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherRepositoryProvider(city.name));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF6631BD),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: weatherState.when(
          data: (weather) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(Icons.cloud, size: 32, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                city.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ToggleCityActions(
                    weather: weather,
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _WeatherDetail(
                      label: 'Wind',
                      value: '${weather.current.windSpeed} km/h'),
                  _WeatherDetail(
                      label: 'Temp', value: '${weather.current.temperature}°C'),
                  _WeatherDetail(
                      label: 'Humidity', value: '${weather.current.humidity}%'),
                ],
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            ),
          ),
          error: (err, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 24),
                const SizedBox(height: 8),
                const Text(
                  'Error loading weather',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () =>
                      ref.refresh(weatherRepositoryProvider(city.name)),
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final String label;
  final String value;

  const _WeatherDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}
