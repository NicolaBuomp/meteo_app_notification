// lib/weather/data/models/condition_model.dart

class WeatherCondition {
  final String text;
  final String iconUrl;
  final int code;

  WeatherCondition({
    required this.text,
    required this.iconUrl,
    required this.code,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'] as String? ?? '',
      iconUrl: json['icon'] != null ? "https:${json['icon']}" : '',
      code: json['code'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'iconUrl': iconUrl,
      'code': code,
    };
  }
}
