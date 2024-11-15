import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/data/models/favorite_city_model.dart';
import 'package:meteo_app_notification/favorite/services/favority_city_service.dart';

class FavoriteCityViewModel
    extends StateNotifier<AsyncValue<List<FavoriteCityModel>>> {
  final FavoriteCityService _cityInfoService;

  FavoriteCityViewModel(this._cityInfoService)
      : super(const AsyncValue.loading()) {
    _loadCityInfo();
  }

  Future<void> _loadCityInfo() async {
    try {
      final cities = await _cityInfoService.loadCityInfo();
      state = AsyncValue.data(cities);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Aggiunge una nuova città e salva.
  Future<void> addCity(String cityName) async {
    final currentState = state.value ?? [];
    if (!currentState.any((c) => c.name == cityName)) {
      final updatedList = [...currentState, FavoriteCityModel(name: cityName)];
      state = AsyncValue.data(updatedList);
      await _cityInfoService.saveCityInfo(updatedList);
    }
  }

  /// Rimuove una città e salva.
  Future<void> removeCity(String cityName) async {
    final currentState = state.value ?? [];
    final updatedList = currentState.where((c) => c.name != cityName).toList();
    state = AsyncValue.data(updatedList);
    await _cityInfoService.saveCityInfo(updatedList);
  }

  /// Attiva/disattiva le notifiche per una città e salva.
  Future<void> toggleNotification(String cityName) async {
    final currentState = state.value ?? [];
    final updatedList = currentState.map((city) {
      if (city.name == cityName) {
        return FavoriteCityModel(
          name: city.name,
          notificationEnabled: !city.notificationEnabled,
          latitude: city.latitude,
          longitude: city.longitude,
          weatherCondition: city.weatherCondition,
        );
      }
      return city;
    }).toList();

    state = AsyncValue.data(updatedList);
    await _cityInfoService.saveCityInfo(updatedList);
  }

  /// Aggiorna le informazioni meteo per una città.
  Future<void> updateWeatherInfo(
      String cityName, String weatherCondition) async {
    final currentState = state.value ?? [];
    final updatedList = currentState.map((city) {
      if (city.name == cityName) {
        return FavoriteCityModel(
          name: city.name,
          notificationEnabled: city.notificationEnabled,
          latitude: city.latitude,
          longitude: city.longitude,
          weatherCondition: weatherCondition,
        );
      }
      return city;
    }).toList();

    state = AsyncValue.data(updatedList);
    await _cityInfoService.saveCityInfo(updatedList);
  }

  /// Rimuove tutte le città.
  Future<void> removeAll() async {
    state = const AsyncValue.data([]);
    await _cityInfoService.clearCityInfoCache();
  }
}
