class FavoriteCityModel {
  final String name;
  bool notificationEnabled;
  final double latitude;
  final double longitude;
  String? weatherCondition;

  FavoriteCityModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.notificationEnabled = false,
    this.weatherCondition,
  });

  factory FavoriteCityModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCityModel(
      name: json['name'] as String,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      notificationEnabled: json['notificationEnabled'] as bool? ?? false,
      weatherCondition: json['weatherCondition'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'notificationEnabled': notificationEnabled,
      'weatherCondition': weatherCondition,
    };
  }
}
