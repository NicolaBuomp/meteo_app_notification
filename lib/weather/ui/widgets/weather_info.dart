import 'package:flutter/material.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_favorite_button.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${weather.temperature}°C',
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              ToggleFavoriteButton(city: weather.location)
            ],
          ),
          Row(
            children: [
              Image.network(
                height: 200,
                width: 200,
                weather.iconUrl,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 36),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translation.weather.humidity,
                        style: TextStyle(
                          color: Color(0xFFB5B5B5),
                        ),
                      ),
                      Text(
                        '${weather.humidity}%',
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translation.weather.wind,
                        style: TextStyle(
                          color: Color(0xFFB5B5B5),
                        ),
                      ),
                      Text(
                        '${weather.windSpeed} km/h',
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      print('Click');
                    },
                    child: Row(
                      children: [
                        Text(
                          context.translation.weather.details,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFB5B5B5),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.open_in_new_rounded,
                          color: Color(0xFFB5B5B5),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
