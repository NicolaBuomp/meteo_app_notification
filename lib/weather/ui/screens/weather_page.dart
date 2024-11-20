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
      body: Stack(
        children: [
          // Contenuto principale avvolto in SafeArea
          SafeArea(
            child: RefreshIndicator(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 18),
                        child: WeatherContent(weather: weatherState.weather!),
                      ),
                    ),
            ),
          ),

          // Overlay di caricamento che copre tutto lo schermo
          if (weatherState.isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

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
    );
  }
}
