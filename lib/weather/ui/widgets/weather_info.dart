// lib/weather/ui/widgets/weather_info.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/weather/ui/widgets/toggle_city_actions.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_icon.dart';
import '../../data/models/weather_model.dart';

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
                '${weather.current.temperature}°C',
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              ToggleCityActions(weather: weather),
            ],
          ),
          Row(
            children: [
              WeatherIconWidget(
                conditionCode: weather.current.condition.code,
                isDayTime: weather.current.isDayTime,
                size: 100.0,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Umidità',
                        style: TextStyle(
                          color: Color(0xFFB5B5B5),
                        ),
                      ),
                      Text(
                        '${weather.current.humidity}%',
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vento',
                        style: TextStyle(
                          color: Color(0xFFB5B5B5),
                        ),
                      ),
                      Text(
                        '${weather.current.windSpeed} km/h',
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      context.push(
                        '/weatherDetails/${weather.location.latitude}/${weather.location.longitude}',
                      );
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Dettagli',
                          style: TextStyle(
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
