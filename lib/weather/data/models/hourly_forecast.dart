class HourlyForecast {
  final int time;
  final double tempC;
  final String condition;
  final String iconUrl;
  final int chanceOfRain;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.iconUrl,
    required this.chanceOfRain,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time_epoch'] != null ? json['time_epoch'] as int : 0,
      tempC: json['temp_c'] != null ? (json['temp_c'] as num).toDouble() : 0.0,
      condition: json['condition']?['text'] as String? ?? 'N/A',
      iconUrl: json['condition']?['icon'] != null
          ? "https:${json['condition']['icon']}"
          : '',
      chanceOfRain:
          json['chance_of_rain'] != null ? json['chance_of_rain'] as int : 0,
    );
  }
}
