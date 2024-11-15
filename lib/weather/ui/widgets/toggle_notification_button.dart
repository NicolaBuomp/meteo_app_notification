import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/widgets/custom_snack_bar.dart';
import 'package:meteo_app_notification/favorite/data/models/favorite_city_model.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class ToggleNotificationButton extends ConsumerWidget {
  final String city;
  final double iconSize;

  const ToggleNotificationButton(
      {super.key, required this.city, required this.iconSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityInfoState = ref.watch(cityInfoViewModelProvider);

    final isNotificationActivated = cityInfoState.when(
      data: (cities) {
        final cityInfo = cities.firstWhere(
          (favoriteCity) => favoriteCity.name == city,
          orElse: () => FavoriteCityModel(
            name: city,
            notificationEnabled: false,
          ),
        );
        return cityInfo.notificationEnabled;
      },
      loading: () => false,
      error: (error, _) => false,
    );

    final isCityInFavorites = cityInfoState.when(
      data: (cities) => cities.any((favoriteCity) => favoriteCity.name == city),
      loading: () => false,
      error: (error, _) => false,
    );

    return IconButton(
      icon: Icon(
        isNotificationActivated
            ? Icons.notifications
            : Icons.notifications_none,
        color: Colors.yellow.shade600,
        size: iconSize,
      ),
      onPressed: () {
        if (isCityInFavorites) {
          ref.read(cityInfoViewModelProvider.notifier).toggleNotification(city);
          ref.read(weatherViewModelProvider.notifier).dailyRainCheck();
        } else {
          CustomSnackBar.show(
            context,
            message:
                'Per abilitare le notifiche, salva prima "$city" nei preferiti.',
            backgroundColor: Colors.yellow.shade800,
            icon: Icons.warning,
          );
        }
      },
    );
  }
}
