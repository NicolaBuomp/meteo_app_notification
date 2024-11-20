import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/Base/widgets/custom_snack_bar.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';

class ToggleFavoriteButton extends ConsumerWidget {
  final String cityName;
  final double iconSize;
  final double latitude; // Aggiunto
  final double longitude; // Aggiunto

  const ToggleFavoriteButton({
    super.key,
    required this.cityName,
    required this.iconSize,
    required this.latitude, // Aggiunto
    required this.longitude, // Aggiunto
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityInfoState = ref.watch(favoriteCityViewModelProvider);
    final cityInfoNotifier = ref.read(favoriteCityViewModelProvider.notifier);

    // Verifica se la città è già nei preferiti
    final isFavorite =
        cityInfoState.cities.any((city) => city.name == cityName);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: iconSize,
      ),
      onPressed: () async {
        try {
          if (isFavorite) {
            await cityInfoNotifier.removeCity(cityName);
            CustomSnackBar.show(
              context,
              message: '$cityName rimossa dai preferiti',
              backgroundColor: Colors.red,
              icon: Icons.favorite_border,
            );
          } else {
            await cityInfoNotifier.addCity(
              cityName,
              latitude, // Passa la latitudine
              longitude, // Passa la longitudine
            );
            CustomSnackBar.show(
              context,
              message: '$cityName aggiunta ai preferiti',
              backgroundColor: Colors.green,
              icon: Icons.favorite,
            );
          }
        } catch (e) {
          CustomSnackBar.show(
            context,
            message: 'Errore: ${e.toString()}',
            backgroundColor: Colors.orange,
            icon: Icons.error,
          );
        }
      },
    );
  }
}
