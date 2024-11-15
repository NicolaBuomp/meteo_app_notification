import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/Base/widgets/custom_snack_bar.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';

class ToggleFavoriteButton extends ConsumerWidget {
  final String city;
  final double iconSize;

  const ToggleFavoriteButton(
      {super.key, required this.city, required this.iconSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityInfoState = ref.watch(cityInfoViewModelProvider);
    final cityInfoNotifier = ref.read(cityInfoViewModelProvider.notifier);

    final isFavorite = cityInfoState.when(
      data: (cities) => cities.any((cityInfo) => cityInfo.name == city),
      loading: () => false,
      error: (error, _) => false,
    );

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: iconSize,
      ),
      onPressed: () async {
        if (isFavorite) {
          await cityInfoNotifier.removeCity(city);
          CustomSnackBar.show(
            context,
            message: '$city rimossa dai preferiti',
            backgroundColor: Colors.red,
            icon: Icons.favorite_border,
          );
        } else {
          await cityInfoNotifier.addCity(city);
          CustomSnackBar.show(
            context,
            message: '$city aggiunta ai preferiti',
            backgroundColor: Colors.green,
            icon: Icons.favorite,
          );
        }
      },
    );
  }
}
