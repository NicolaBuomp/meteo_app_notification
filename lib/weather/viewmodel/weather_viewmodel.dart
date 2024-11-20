import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo_app_notification/services/notifications/local_notifications_services.dart';
import 'package:meteo_app_notification/weather/data/models/search_city_model.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';
import 'package:meteo_app_notification/weather/data/repository/weather_repository.dart';
import 'package:meteo_app_notification/weather/services/weather_service.dart';
import 'package:meteo_app_notification/weather/services/weather_notification_service.dart';

// Custom Exceptions
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error occurred']);
}

class LocationException implements Exception {
  final String message;
  LocationException([this.message = 'Location service error']);
}

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
      state = state.copyWith(error: _mapErrorMessage(e), isLoading: false);
    }
  }

  /// Carica i dati meteo per una città specifica.
  Future<void> loadWeatherByCity(String cityName, {int days = 3}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final weather = await _repository.getWeatherByCity(cityName, days);

      await _weatherService.saveWeatherData(weather);
      state = state.copyWith(weather: weather, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: _mapErrorMessage(e), weather: null);
    }
  }

  /// Carica i dati meteo in base alla posizione geografica.
  Future<void> loadWeatherByLocation(double latitude, double longitude,
      {int days = 3}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final weather =
          await _repository.getWeatherByCoordinates(latitude, longitude, days);

      await _weatherService.saveWeatherData(weather);
      state = state.copyWith(weather: weather, isLoading: false);
    } on NetworkException catch (e) {
      state = state.copyWith(
          isLoading: false, error: _mapErrorMessage(e), weather: null);
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: 'Unexpected error: ${e.toString()}',
          weather: null);
    }
  }

  /// Carica i dati meteo con il permesso della posizione.
  Future<void> loadWeatherWithPermission() async {
    try {
      final position = await _determinePosition();
      await loadWeatherByLocation(position.latitude, position.longitude);
    } on LocationException catch (e) {
      state = state.copyWith(error: _mapErrorMessage(e), isLoading: false);
    } catch (e) {
      state = state.copyWith(
          error: 'Location error: ${e.toString()}', isLoading: false);
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
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException('Location permission permanently denied');
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
    if (query.isEmpty || query.length < 3) {
      state = state.copyWith(searchResults: [], error: null);
      return [];
    }
    try {
      final results = await _repository.searchCities(query);

      if (results.isEmpty) {
        state = state.copyWith(
            searchResults: [], error: 'Nessun risultato trovato per "$query"');
      } else {
        state = state.copyWith(searchResults: results, error: null);
      }

      return results;
    } catch (e) {
      state = state.copyWith(searchResults: [], error: _mapErrorMessage(e));
      return [];
    }
  }

  /// Cancella i risultati della ricerca.
  void clearSearchResults() {
    state = state.copyWith(searchResults: []);
  }

  /// Mappa gli errori in messaggi leggibili.
  String _mapErrorMessage(dynamic error) {
    if (error is NetworkException) {
      return 'Network error. Check your connection.';
    } else if (error is LocationException) {
      return 'Location services unavailable.';
    }
    return 'Unexpected error: ${error.toString()}';
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
