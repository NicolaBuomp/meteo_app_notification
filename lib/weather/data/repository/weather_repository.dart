import 'package:dio/dio.dart';
import 'package:meteo_app_notification/weather/data/models/search_city_model.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final Dio _dio = Dio();
  final String _apiKey = '5a6c17f7e5f94ff09bf180911242910';
  final String _baseUrl = 'http://api.weatherapi.com/v1/forecast.json';

  Future<WeatherModel> getWeatherByCity(String city, int days) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'q': city,
          'days': days,
          'lang': 'it',
          'aqi': 'no',
          'alerts': 'yes',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data for city: $e');
    }
  }

  Future<WeatherModel> getWeatherByCoordinates(
      double latitude, double longitude, int days) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'q': '$latitude,$longitude',
          'days': days,
          'lang': 'it',
          'alerts': 'yes',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data for coordinates: $e');
    }
  }

  Future<List<SearchCityModel>> searchCities(String query) async {
    final String url = '$_baseUrl/search.json';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'key': _apiKey,
          'q': query,
          'lang': 'it',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<SearchCityModel> cities =
            data.map((json) => SearchCityModel.fromJson(json)).toList();
        return cities;
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      throw Exception('Error fetching city data: $e');
    }
  }
}
