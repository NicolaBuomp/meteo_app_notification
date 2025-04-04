import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo_app_notification/services/notifications/local_notifications_services.dart';
import 'package:meteo_app_notification/weather/services/weather_notification_service.dart';
import '../data/models/weather_model.dart';
import '../data/repository/weather_repository.dart';
import '../services/weather_service.dart';

class WeatherViewModel extends StateNotifier<AsyncValue<WeatherModel?>> {
  final WeatherRepository _repository;
  final WeatherService _weatherService;
  final WeatherNotificationService _notificationService;

  WeatherViewModel(
    this._repository,
    this._weatherService,
    this._notificationService,
  ) : super(const AsyncValue.loading()) {
    _initializeWeatherData();
  }

  Future<void> _initializeWeatherData() async {
    try {
      // Step 1: Carica i dati dalla cache
      final cachedWeather = await _weatherService.getWeatherData();
      if (cachedWeather != null) {
        state = AsyncValue.data(cachedWeather);
      }

      // Step 2: Aggiorna i dati con la posizione attuale
      await loadWeatherWithPermission();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadWeatherByCity(String city, {int days = 3}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _repository.getWeatherByCity(city, days);
      await _weatherService.saveWeatherData(weather); // Salva nella cache
      state = AsyncValue.data(weather);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadWeatherByLocation(double latitude, double longitude,
      {int days = 3}) async {
    try {
      final weather =
          await _repository.getWeatherByCoordinates(latitude, longitude, days);
      await _weatherService.saveWeatherData(weather);
      state = AsyncValue.data(weather);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadWeatherWithPermission() async {
    try {
      final position = await _determinePosition();
      await loadWeatherByLocation(position.latitude, position.longitude);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refreshWeather({int days = 3}) async {
    if (state.value != null) {
      final lat = state.value!.location.latitude;
      final long = state.value!.location.longitude;
      await loadWeatherByLocation(lat, long, days: days);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(
          'I servizi di localizzazione sono disabilitati. Abilitali nelle impostazioni.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permesso di localizzazione negato.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permesso negato permanentemente. Abilitalo nelle impostazioni.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> clearWeatherData() async {
    state = const AsyncValue.data(null);
    await _weatherService.clearWeatherCache();
  }

  Future<void> dailyRainCheck() async {
    try {
      if (state.value != null) {
        await _notificationService.checkDailyRain(state.value!);
      }
    } catch (e) {
      print('Errore durante il controllo della pioggia: $e');
    }
  }
}

final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, AsyncValue<WeatherModel?>>((ref) {
  final repository = WeatherRepository();
  final weatherService = WeatherService();
  final localNotificationsService = LocalNotificationsService();
  final weatherNotificationService =
      WeatherNotificationService(localNotificationsService);

  return WeatherViewModel(
      repository, weatherService, weatherNotificationService);
});
