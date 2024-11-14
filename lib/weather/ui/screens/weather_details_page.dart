import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/ui/widgets/custom_app_bar_details.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_details_content.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_forecast.dart';
import 'package:meteo_app_notification/weather/ui/widgets/weather_hourly_forecast.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class WeatherDetailsPage extends ConsumerWidget {
  final String? latitude;
  final String? longitude;

  const WeatherDetailsPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (latitude != null && longitude != null) {
        weatherViewModel.loadWeatherByLocation(
            double.parse(latitude!), double.parse(longitude!),
            days: 3);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: weatherViewModel.refreshWeather,
          child: weatherState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (weather) {
              if (weather == null) {
                return const Center(
                  child: Text(
                    'No weather data available.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Column(
                children: [
                  CustomAppBar(weather: weather),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: Column(
                                children: [
                                  WeatherDetailsContent(weather: weather),
                                  WeatherHourlyForecast(
                                    hourly: weather.forecast.first.hourly,
                                    localtime: weather.localtime,
                                  ),
                                ],
                              ),
                            ),
                            WeatherForecast(forecast: weather.forecast),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, _) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
