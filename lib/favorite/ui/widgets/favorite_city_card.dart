import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/theme/app_colors.dart';
import 'package:meteo_app_notification/favorite/data/models/favorite_city_model.dart';
import 'package:meteo_app_notification/weather/di/weather_provider.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_city_actions.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_icon.dart';

class FavoriteCityCard extends ConsumerWidget {
  final FavoriteCityModel city;
  final VoidCallback onTap;

  const FavoriteCityCard({
    super.key,
    required this.city,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherRepositoryProvider(city.name));
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor =
        isDarkMode ? AppColors.darkCard : AppColors.lightCard;
    final List<BoxShadow> boxShadow = [
      BoxShadow(
        color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 1),
      ),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: boxShadow,
        ),
        child: weatherState.when(
          data: (weather) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        WeatherIconWidget(
                          conditionCode: weather.current.condition.code,
                          isDayTime: weather.current.isDayTime,
                          size: 40.0,
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            city.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _WeatherDetail(
                    label: 'Temperatura',
                    value: '${weather.current.temperature}°C',
                  ),
                  _WeatherDetail(
                    label: 'Vento',
                    value: '${weather.current.windSpeed} km/h',
                  ),
                  _WeatherDetail(
                    label: 'Umidità',
                    value: '${weather.current.humidity}%',
                  ),
                ],
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
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
                  'Errore nel caricamento',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () =>
                      ref.refresh(weatherRepositoryProvider(city.name)),
                  child: const Text(
                    'Riprova',
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
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
