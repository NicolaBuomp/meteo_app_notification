import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/widgets/top_bar.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/ui/widgets/favorite_city_card.dart';
import 'package:meteo_app_notification/weather/viewmodel/favorite_cities_viewmodel.dart';

class FavoriteCityList extends ConsumerWidget {
  const FavoriteCityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCitiesState = ref.watch(favoriteCitiesViewModelProvider);

    return favoriteCitiesState.when(
      data: (cities) {
        return Column(
          children: [
            TopBar(title: context.translation.favorites.title),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: cities.map((city) {
                  return FavoriteCityCard(
                    city: city,
                    onTap: () {},
                  );
                }).toList(),
              ),
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
