import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/services/favority_city_service.dart';
import 'package:meteo_app_notification/favorite/viewmodel/favorite_city_viewmodel.dart';

final favoriteCityViewModelProvider =
    StateNotifierProvider<FavoriteCityViewModel, FavoriteCityState>((ref) {
  return FavoriteCityViewModel(FavoriteCityService());
});
