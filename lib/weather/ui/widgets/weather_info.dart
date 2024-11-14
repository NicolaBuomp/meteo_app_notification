import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toglle_city_actions.dart';

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
              ToggleCityActions(weather: weather),
            ],
          ),
          Row(
            children: [
              Image.network(
                weather.iconUrl,
                height: 180,
                width: 180,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 180,
                    color: Colors.grey,
                  );
                },
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
                      context.push(
                        '/weatherDetails/${weather.latitude}/${weather.longitude}',
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          context.translation.weather.details,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFFB5B5B5),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.open_in_new_rounded,
                          color: Color(0xFFB5B5B5),
                        ),
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
