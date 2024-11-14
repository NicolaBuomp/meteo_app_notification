class CityInfo {
  final String name;
  bool notificationEnabled;
  double? latitude;
  double? longitude;
  String? weatherCondition;

  CityInfo({
    required this.name,
    this.notificationEnabled = false,
    this.latitude,
    this.longitude,
    this.weatherCondition,
  });

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      name: json['name'] as String,
      notificationEnabled: json['notificationEnabled'] as bool? ?? false,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      weatherCondition: json['weatherCondition'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notificationEnabled': notificationEnabled,
      'latitude': latitude,
      'longitude': longitude,
      'weatherCondition': weatherCondition,
    };
  }
}
