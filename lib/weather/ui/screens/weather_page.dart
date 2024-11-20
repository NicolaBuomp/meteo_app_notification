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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async => await weatherViewModel.refreshWeather(),
              child: weatherState.weather == null
                  ? Center(
                      child: Text(
                        'Nessun dato meteo disponibile.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: WeatherContent(weather: weatherState.weather!),
                    ),
            ),

            // Overlay di caricamento
            if (weatherState.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),

            // Gestione degli errori
            if (weatherState.error != null)
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Errore: ${weatherState.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: () => weatherViewModel.refreshWeather(),
                        child: Text('Riprova'),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
