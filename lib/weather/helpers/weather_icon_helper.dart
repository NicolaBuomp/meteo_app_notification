import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData getWeatherIcon(int conditionCode, bool isDayTime) {
  if (conditionCode == 1000) {
    // Clear/Sunny
    return isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
  } else if (conditionCode == 1003) {
    // Partly cloudy
    return isDayTime ? WeatherIcons.day_cloudy : WeatherIcons.night_alt_cloudy;
  } else if (conditionCode == 1006) {
    // Cloudy
    return WeatherIcons.cloud;
  } else if (conditionCode == 1009) {
    // Overcast
    return WeatherIcons.cloudy;
  } else if ([1030, 1135, 1147].contains(conditionCode)) {
    // Mist, Fog
    return WeatherIcons.fog;
  } else if ([1063, 1150, 1153, 1180, 1183, 1240].contains(conditionCode)) {
    // Light rain
    return isDayTime
        ? WeatherIcons.day_showers
        : WeatherIcons.night_alt_showers;
  } else if ([1066, 1114, 1210, 1213, 1216, 1255].contains(conditionCode)) {
    // Light snow
    return isDayTime ? WeatherIcons.day_snow : WeatherIcons.night_alt_snow;
  } else if ([1087, 1273, 1276].contains(conditionCode)) {
    // Thunderstorms
    return isDayTime
        ? WeatherIcons.day_thunderstorm
        : WeatherIcons.night_alt_thunderstorm;
  } else if ([1117, 1219, 1222, 1225, 1258, 1261, 1264, 1279, 1282]
      .contains(conditionCode)) {
    // Heavy snow, Blizzard
    return WeatherIcons.snow_wind;
  } else if ([1072, 1168, 1171, 1198, 1201, 1237, 1249, 1252]
      .contains(conditionCode)) {
    // Freezing drizzle, Ice pellets
    return WeatherIcons.sleet;
  } else if ([1186, 1189, 1192, 1195, 1243, 1246].contains(conditionCode)) {
    // Moderate or heavy rain
    return isDayTime ? WeatherIcons.day_rain : WeatherIcons.night_alt_rain;
  } else if ([1069, 1204, 1207].contains(conditionCode)) {
    // Sleet
    return WeatherIcons.sleet;
  } else if ([1279, 1282].contains(conditionCode)) {
    // Snow with thunder
    return isDayTime
        ? WeatherIcons.day_snow_thunderstorm
        : WeatherIcons.night_alt_snow_thunderstorm;
  } else {
    // Default icon
    return WeatherIcons.na;
  }
}
