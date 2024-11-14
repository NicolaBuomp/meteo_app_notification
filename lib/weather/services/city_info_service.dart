import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meteo_app_notification/weather/data/models/city_info_model.dart';

class CityInfoService {
  static const String _cacheCityInfo = 'cacheCityInfo';

  /// Carica tutte le città dal cache.
  Future<List<CityInfo>> loadCityInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final cityInfoData = prefs.getString(_cacheCityInfo);

    if (cityInfoData != null) {
      final decodedData = jsonDecode(cityInfoData) as List<dynamic>;
      return decodedData
          .map((city) => CityInfo.fromJson(city as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Salva la lista aggiornata delle città.
  Future<void> saveCityInfo(List<CityInfo> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final cityInfoJson =
        jsonEncode(cities.map((city) => city.toJson()).toList());
    await prefs.setString(_cacheCityInfo, cityInfoJson);
  }

  /// Rimuove tutte le città dalla cache.
  Future<void> clearCityInfoCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheCityInfo);
  }
}
