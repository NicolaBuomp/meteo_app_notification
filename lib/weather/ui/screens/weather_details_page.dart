import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_app_bar_details.dart';
import '../widgets/weather_details_content.dart';
import '../widgets/weather_forecast.dart';
import '../widgets/weather_hourly_forecast.dart';
import '../../viewmodel/weather_viewmodel.dart';

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
          double.parse(latitude!),
          double.parse(longitude!),
          days: 3,
        );
      }
    });

    if (weatherState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (weatherState.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${weatherState.error}'),
        ),
      );
    }

    if (weatherState.weather == null) {
      return const Scaffold(
        body: Center(
          child: Text('No weather data available.'),
        ),
      );
    }

    final weather = weatherState.weather!;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: weatherViewModel.refreshWeather,
          child: Column(
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
                                localtimeEpoch: weather.location.localtimeEpoch,
                                timezoneId: weather.location.timezoneId,
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
          ),
        ),
      ),
    );
  }
}
