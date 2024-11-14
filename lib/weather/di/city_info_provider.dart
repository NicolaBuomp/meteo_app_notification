import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/weather/data/models/city_info_model.dart';
import 'package:meteo_app_notification/weather/services/city_info_service.dart';
import 'package:meteo_app_notification/weather/viewmodel/city_info_viewmodel.dart';

final cityInfoViewModelProvider =
    StateNotifierProvider<CityInfoViewModel, AsyncValue<List<CityInfo>>>((ref) {
  return CityInfoViewModel(CityInfoService());
});
