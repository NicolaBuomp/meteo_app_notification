import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/data/models/favorite_city_model.dart';
import 'package:meteo_app_notification/favorite/services/favority_city_service.dart';

class FavoriteCityState {
  final List<FavoriteCityModel> cities;
  final bool isLoading;
  final String errorMessage;

  FavoriteCityState({
    this.cities = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  FavoriteCityState copyWith({
    List<FavoriteCityModel>? cities,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoriteCityState(
      cities: cities ?? this.cities,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class FavoriteCityViewModel extends StateNotifier<FavoriteCityState> {
  final FavoriteCityService _cityInfoService;

  FavoriteCityViewModel(this._cityInfoService) : super(FavoriteCityState()) {
    loadCityInfo();
  }

  Future<void> loadCityInfo() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final cities = await _cityInfoService.loadCityInfo();
      state = state.copyWith(cities: cities, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addCity(
      String cityName, double latitude, double longitude) async {
    try {
      final currentState = state.cities;
      if (!currentState.any((c) => c.name == cityName)) {
        final updatedList = [
          ...currentState,
          FavoriteCityModel(
            name: cityName,
            latitude: latitude,
            longitude: longitude,
          ),
        ];
        state = state.copyWith(cities: updatedList);
        await _cityInfoService.saveCityInfo(updatedList);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> removeCity(String cityName) async {
    try {
      final currentState = state.cities;
      final updatedList =
          currentState.where((c) => c.name != cityName).toList();
      state = state.copyWith(cities: updatedList);
      await _cityInfoService.saveCityInfo(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> toggleNotification(String cityName) async {
    try {
      final currentState = state.cities;
      final updatedList = currentState.map((city) {
        if (city.name == cityName) {
          return FavoriteCityModel(
            name: city.name,
            latitude: city.latitude,
            longitude: city.longitude,
            notificationEnabled: !city.notificationEnabled,
            weatherCondition: city.weatherCondition,
          );
        }
        return city;
      }).toList();

      state = state.copyWith(cities: updatedList);
      await _cityInfoService.saveCityInfo(updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> removeAll() async {
    try {
      state = state.copyWith(cities: []);
      await _cityInfoService.clearCityInfoCache();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
