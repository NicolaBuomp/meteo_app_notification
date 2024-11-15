// Assicurati che il nome del file sia corretto: lib/weather/ui/widgets/toggle_city_actions.dart

import 'package:flutter/material.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_favorite_button.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_notification_button.dart';

class ToggleCityActions extends StatelessWidget {
  final WeatherModel weather;
  final double iconSize;

  const ToggleCityActions({
    super.key,
    required this.weather,
    this.iconSize = 38.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ToggleFavoriteButton(
          city: weather.location.name,
          iconSize: iconSize,
        ),
        ToggleNotificationButton(
          city: weather.location.name,
          iconSize: iconSize,
        ),
      ],
    );
  }
}
