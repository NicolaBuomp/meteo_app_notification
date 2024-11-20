class Location {
  final String name;
  final String region;
  final String country;
  final String localtime;
  final int localtimeEpoch;
  final double latitude;
  final double longitude;
  final String timezoneId;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
    required this.localtimeEpoch,
    required this.latitude,
    required this.longitude,
    required this.timezoneId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String? ?? '',
      region: json['region'] as String? ?? '',
      country: json['country'] as String? ?? '',
      localtime: json['localtime'] as String? ?? '',
      localtimeEpoch: json['localtime_epoch'] as int? ?? 0,
      latitude: (json['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['lon'] as num?)?.toDouble() ?? 0.0,
      timezoneId: json['tz_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'localtime': localtime,
      'localtime_epoch': localtimeEpoch,
      'lat': latitude,
      'lon': longitude,
      'timezone_id': timezoneId,
    };
  }
}
