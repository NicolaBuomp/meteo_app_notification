import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo_app_notification/services/notifications/local_notifications_services.dart';
import 'package:meteo_app_notification/weather/data/models/search_city_model.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:meteo_app_notification/weather/data/repository/weather_repository.dart';
import 'package:meteo_app_notification/weather/services/weather_service.dart';
import 'package:meteo_app_notification/weather/services/weather_notification_service.dart';

class WeatherState {
  final bool isLoading;
  final List<SearchCityModel> searchResults;
  final WeatherModel? weather;
  final String? error;

  WeatherState({
    this.isLoading = false,
    this.searchResults = const [],
    this.weather,
    this.error,
  });

  WeatherState copyWith({
    bool? isLoading,
    List<SearchCityModel>? searchResults,
    WeatherModel? weather,
    String? error,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }
}

class WeatherViewModel extends StateNotifier<WeatherState> {
  final WeatherRepository _repository;
  final WeatherService _weatherService;
  final WeatherNotificationService _notificationService;

  WeatherViewModel(
    this._repository,
    this._weatherService,
    this._notificationService,
  ) : super(WeatherState(isLoading: true)) {
    _initializeWeatherData();
  }

  /// Inizializza i dati meteo caricando quelli in cache e aggiornandoli con la posizione corrente.
  Future<void> _initializeWeatherData() async {
    try {
      final cachedWeather = await _weatherService.getWeatherData();
      if (cachedWeather != null) {
        state = state.copyWith(weather: cachedWeather, isLoading: false);
      }
      await loadWeatherWithPermission();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Carica i dati meteo per una città specifica.
  Future<void> loadWeatherByCity(String cityName, {int days = 3}) async {
    try {
      state = state.copyWith(isLoading: true);
      final weather = await _repository.getWeatherByCity(cityName, days);
      await _weatherService.saveWeatherData(weather);
      state = state.copyWith(weather: weather, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Carica i dati meteo in base alla posizione geografica.
  Future<void> loadWeatherByLocation(double latitude, double longitude,
      {int days = 3}) async {
    try {
      state = state.copyWith(isLoading: true);
      final weather =
          await _repository.getWeatherByCoordinates(latitude, longitude, days);
      await _weatherService.saveWeatherData(weather);
      state = state.copyWith(weather: weather, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Carica i dati meteo con il permesso della posizione.
  Future<void> loadWeatherWithPermission() async {
    try {
      final position = await _determinePosition();
      await loadWeatherByLocation(position.latitude, position.longitude);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Aggiorna i dati meteo per la posizione corrente.
  Future<void> refreshWeather({int days = 3}) async {
    if (state.weather != null) {
      final lat = state.weather!.location.latitude;
      final long = state.weather!.location.longitude;
      await loadWeatherByLocation(lat, long, days: days);
    }
  }

  /// Determina la posizione corrente dell'utente.
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

  /// Cancella i dati meteo attualmente caricati.
  Future<void> clearWeatherData() async {
    state = WeatherState();
    await _weatherService.clearWeatherCache();
  }

  /// Controlla se è prevista pioggia oggi e invia una notifica.
  Future<void> dailyRainCheck() async {
    try {
      if (state.weather != null) {
        await _notificationService.checkDailyRain(state.weather!);
      }
    } catch (e) {
      print('Errore durante il controllo della pioggia: $e');
    }
  }

  /// Effettua una ricerca per città in base alla query fornita.
  Future<List<SearchCityModel>> searchCities(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(searchResults: []);
      return [];
    }
    try {
      final results = await _repository.searchCities(query);
      state = state.copyWith(searchResults: results);
      return results;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return [];
    }
  }

  /// Cancella i risultati della ricerca.
  void clearSearchResults() {
    state = state.copyWith(searchResults: []);
  }
}

final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
  final repository = WeatherRepository();
  final weatherService = WeatherService();
  final localNotificationsService = LocalNotificationsService();
  final weatherNotificationService =
      WeatherNotificationService(localNotificationsService);

  return WeatherViewModel(
      repository, weatherService, weatherNotificationService);
});
