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
    this.iconSize = 38.0, // Imposta un valore predefinito nel costruttore
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ToggleFavoriteButton(
          city: weather.location,
          iconSize: iconSize,
        ),
        ToggleNotificationButton(
          city: weather.location,
          iconSize: iconSize,
        ),
      ],
    );
  }
}
