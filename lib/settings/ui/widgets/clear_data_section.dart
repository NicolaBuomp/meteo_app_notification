import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/viewmodel/favorite_cities_viewmodel.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class ClearDataSection extends ConsumerWidget {
  const ClearDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);
    final favoriteCitiesViewModel =
        ref.read(favoriteCitiesViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            await weatherViewModel.clearWeatherData();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  translation.settings.actions.clear_weather_confirmation,
                ),
              ),
            );
          },
          child: Text(translation.settings.actions.clear_weather),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await favoriteCitiesViewModel.removeAll();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  translation.settings.actions.clear_favorites_confirmation,
                ),
              ),
            );
          },
          child: Text(translation.settings.actions.clear_favorites),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await weatherViewModel.clearWeatherData();
            await favoriteCitiesViewModel.removeAll();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  translation.settings.actions.clear_all_confirmation,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            translation.settings.actions.clear_all,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
