import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/data/models/favorite_city_model.dart';
import 'package:meteo_app_notification/favorite/services/favority_city_service.dart';
import 'package:meteo_app_notification/favorite/viewmodel/favorite_city_viewmodel.dart';

final cityInfoViewModelProvider = StateNotifierProvider<FavoriteCityViewModel,
    AsyncValue<List<FavoriteCityModel>>>((ref) {
  return FavoriteCityViewModel(FavoriteCityService());
});
