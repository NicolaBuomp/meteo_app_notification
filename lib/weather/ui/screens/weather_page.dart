import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../widgets/weather_content.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);

    if (weatherState.isLoading && weatherState.weather == null) {
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

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await weatherViewModel.refreshWeather(),
          child: weatherState.weather == null
              ? const Center(
                  child: Text(
                    'Nessun dato meteo disponibile.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : WeatherContent(weather: weatherState.weather!),
        ),
      ),
    );
  }
}
