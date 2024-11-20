import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/weather_model.dart';
import '../../viewmodel/weather_viewmodel.dart';
import 'custom_search_input.dart';
import 'weather_info.dart';
import 'weather_forecast.dart';
import 'weather_hourly_forecast.dart';

class WeatherContent extends ConsumerStatefulWidget {
  final WeatherModel weather;

  const WeatherContent({super.key, required this.weather});

  @override
  _WeatherContentState createState() => _WeatherContentState();
}

class _WeatherContentState extends ConsumerState<WeatherContent> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherViewModelProvider);
    String hintText = 'Cerca...';

    if (weatherState.weather?.location != null) {
      final name = weatherState.weather?.location.name;
      final region = weatherState.weather?.location.region;
      final country = weatherState.weather?.location.country;

      hintText = [
        if (name != null && name.isNotEmpty) name,
        if (region != null && region.isNotEmpty) region,
        if (country != null && country.isNotEmpty) country,
      ].join(', ');
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: CustomSearchInput(
              controller: searchController,
              hintText: hintText,
              onLeadingIconTap: () async {
                await ref
                    .read(weatherViewModelProvider.notifier)
                    .loadWeatherWithPermission();
              },
              onCitySelected: (city) {
                ref
                    .read(weatherViewModelProvider.notifier)
                    .loadWeatherByLocation(city.lat, city.lon);
              },
            ),
          ),
          Column(
            children: [
              WeatherInfo(weather: widget.weather),
              WeatherHourlyForecast(
                hourly: widget.weather.forecast.first.hourly,
                localtimeEpoch: widget.weather.location.localtimeEpoch,
                timezoneId: widget.weather.location.timezoneId,
              ),
              WeatherForecast(forecast: widget.weather.forecast),
            ],
          ),
        ],
      ),
    );
  }
}
