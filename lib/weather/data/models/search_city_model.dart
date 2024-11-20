// city_model.dart
class SearchCityModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  SearchCityModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    return SearchCityModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      url: json['url'] ?? '',
    );
  }
}
