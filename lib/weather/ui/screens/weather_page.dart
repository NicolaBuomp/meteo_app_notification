import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/ui/widgets/search_input.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../widgets/weather_content.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);
    final searchController = TextEditingController();

    String hintText = "Cerca";
    weatherState.whenData((weather) {
      if (weather != null) {
        hintText = '${weather.location}, ${weather.region}, ${weather.country}';
      }
    });

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: weatherViewModel.refreshWeather,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomSearchInput(
                  controller: searchController,
                  hintText: hintText,
                  leadingIcon: Icons.location_on_rounded,
                  trailingIcon: Icons.send_rounded,
                  onLeadingIconTap: () async {
                    try {
                      await weatherViewModel.loadWeatherWithPermission();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Errore: $e')),
                      );
                    }
                  },
                  onTrailingIconTap: () {
                    final city = searchController.text.trim();
                    if (city.isNotEmpty) {
                      weatherViewModel.loadWeatherByCity(city);
                      searchController.clear();
                    }
                  },
                ),
              ),
              Expanded(
                child: weatherState.when(
                  data: (weather) => WeatherContent(),
                  loading: () => const Center(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => Center(
                    child: Text(
                      'Errore: $err',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
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
