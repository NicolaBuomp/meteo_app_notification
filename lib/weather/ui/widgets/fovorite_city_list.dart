import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/widgets/top_bar.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/di/city_info_provider.dart';
import 'package:meteo_app_notification/weather/ui/widgets/favorite_city_card.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class FavoriteCityList extends ConsumerWidget {
  const FavoriteCityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityInfoState = ref.watch(cityInfoViewModelProvider);

    return cityInfoState.when(
      data: (cities) {
        if (cities.isEmpty) {
          return const Center(
            child: Text('Nessuna città preferita'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TopBar(title: context.translation.favorites.title),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return FavoriteCityCard(
                  city: city,
                  onTap: () {
                    final weatherViewModel =
                        ref.read(weatherViewModelProvider.notifier);
                    weatherViewModel.loadWeatherByCity(city.name);
                  },
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
