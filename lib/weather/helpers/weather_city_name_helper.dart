import 'package:meteo_app_notification/weather/data/models/search_city_model.dart';
import 'package:meteo_app_notification/weather/data/models/weather_model.dart';

String getCityNameText(WeatherModel? weather) {
  if (weather?.location != null) {
    final name = weather?.location.name;
    final region = weather?.location.region;
    final country = weather?.location.country;

    return [
      if (name != null && name.isNotEmpty) name,
      if (region != null && region.isNotEmpty) region,
      if (country != null && country.isNotEmpty) country,
    ].join(', ');
  }
  return 'Cerca...';
}

String getSearchCityNameText(SearchCityModel? weather) {
  if (weather != null) {
    final name = weather.name;
    final region = weather.region;
    final country = weather.country;

    return [
      if (name.isNotEmpty) name,
      if (region.isNotEmpty) region,
      if (country.isNotEmpty) country,
    ].join(', ');
  }
  return 'Cerca...';
}
