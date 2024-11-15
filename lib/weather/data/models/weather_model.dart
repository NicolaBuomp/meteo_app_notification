class WeatherModel {
  final String location;
  final String region;
  final String country;
  final int localtime;
  final double temperature;
  final String condition;
  final String iconUrl;
  final int humidity;
  final double windSpeed;
  final double feelsLike;
  final double uvIndex;
  final double maxTemp;
  final double minTemp;
  final double totalPrecip;
  final int chanceOfRain;
  final String sunrise;
  final String sunset;
  final double latitude;
  final double longitude;
  final List<DailyForecast> forecast;

  WeatherModel({
    required this.location,
    required this.region,
    required this.country,
    required this.localtime,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.uvIndex,
    required this.maxTemp,
    required this.minTemp,
    required this.totalPrecip,
    required this.chanceOfRain,
    required this.sunrise,
    required this.sunset,
    required this.latitude,
    required this.longitude,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location']?['name'] ?? '',
      region: json['location']?['region'] ?? '',
      country: json['location']?['country'] ?? '',
      localtime: json['location']?['localtime_epoch'] ?? 0,
      latitude: json['location']?['lat'] ?? 0.0,
      longitude: json['location']?['lon'] ?? 0.0,
      temperature: json['current']?['temp_c'] ?? 0.0,
      condition: json['current']?['condition']?['text'] ?? '',
      iconUrl: "https:${json['current']?['condition']?['icon'] ?? ''}",
      humidity: json['current']?['humidity'] ?? 0,
      windSpeed: json['current']?['wind_kph'] ?? 0.0,
      feelsLike: json['current']?['feelslike_c'] ?? 0.0,
      uvIndex: json['current']?['uv'] ?? 0.0,
      maxTemp:
          json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c'] ?? 0.0,
      minTemp:
          json['forecast']?['forecastday']?[0]?['day']?['mintemp_c'] ?? 0.0,
      totalPrecip: json['forecast']?['forecastday']?[0]?['day']
              ?['totalprecip_mm'] ??
          0.0,
      chanceOfRain: json['forecast']?['forecastday']?[0]?['day']
              ?['daily_chance_of_rain'] ??
          0,
      sunrise: json['forecast']?['forecastday']?[0]?['astro']?['sunrise'] ?? '',
      sunset: json['forecast']?['forecastday']?[0]?['astro']?['sunset'] ?? '',
      forecast: (json['forecast']?['forecastday'] as List<dynamic>? ?? [])
          .map((day) => DailyForecast.fromJson(day))
          .toList(),
    );
  }
}

class DailyForecast {
  final int date;
  final double maxTemp;
  final double minTemp;
  final double totalPrecip;
  final int chanceOfRain;
  final String condition;
  final String iconUrl;
  final List<HourlyForecast> hourly;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.totalPrecip,
    required this.chanceOfRain,
    required this.condition,
    required this.iconUrl,
    required this.hourly,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date_epoch'] ?? 0,
      maxTemp: json['day']?['maxtemp_c'] ?? 0.0,
      minTemp: json['day']?['mintemp_c'] ?? 0.0,
      totalPrecip: json['day']?['totalprecip_mm'] ?? 0.0,
      chanceOfRain: json['day']?['daily_chance_of_rain'] ?? 0,
      condition: json['day']?['condition']?['text'] ?? '',
      iconUrl: "https:${json['day']?['condition']?['icon'] ?? ''}",
      hourly: (json['hour'] as List<dynamic>? ?? [])
          .map((hour) => HourlyForecast.fromJson(hour))
          .toList(),
    );
  }
}

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
      time: json['time_epoch'] ?? 0,
      tempC: json['temp_c'] ?? 0.0,
      condition: json['condition']?['text'] ?? '',
      iconUrl: "https:${json['condition']?['icon'] ?? ''}",
      chanceOfRain: json['chance_of_rain'] ?? 0,
    );
  }
}
