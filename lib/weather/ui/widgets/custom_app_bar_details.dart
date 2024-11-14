import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toglle_city_actions.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';

class CustomAppBar extends StatelessWidget {
  final WeatherModel weather;

  const CustomAppBar({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          ToggleCityActions(
            weather: weather,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
