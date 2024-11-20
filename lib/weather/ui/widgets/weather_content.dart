import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/helpers/weather_city_name_helper.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchInput(
            controller: searchController,
            hintText: getCityNameText(weatherState.weather),
            maxResults: 3,
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
