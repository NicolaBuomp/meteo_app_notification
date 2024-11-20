import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';
import 'package:meteo_app_notification/favorite/ui/widgets/favorite_city_card.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class FavoriteCityList extends ConsumerWidget {
  const FavoriteCityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Recupera lo stato del provider
    final cityInfoState = ref.watch(favoriteCityViewModelProvider);

    if (cityInfoState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cityInfoState.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 24),
            const SizedBox(height: 8),
            Text(
              'Errore: ${cityInfoState.errorMessage}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ricarica le città preferite in caso di errore
                ref.read(favoriteCityViewModelProvider.notifier).loadCityInfo();
              },
              child: const Text('Riprova'),
            ),
          ],
        ),
      );
    }

    if (cityInfoState.cities.isEmpty) {
      return const Center(
        child: Text(
          'Nessuna città preferita',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: cityInfoState.cities.length,
      itemBuilder: (context, index) {
        final city = cityInfoState.cities[index];
        return FavoriteCityCard(
          city: city,
          onTap: () {
            final weatherViewModel =
                ref.read(weatherViewModelProvider.notifier);
            weatherViewModel.loadWeatherByLocation(
              city.latitude,
              city.longitude,
            );
            context.go('/weather');
          },
        );
      },
    );
  }
}
