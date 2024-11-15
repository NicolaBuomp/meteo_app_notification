// weather_icon_widget.dart

import 'package:flutter/material.dart';
import 'package:meteo_app_notification/weather/helpers/weather_icon_helper.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIconWidget extends StatelessWidget {
  final int conditionCode;
  final bool isDayTime;
  final double size;
  final Color color;

  const WeatherIconWidget({
    super.key,
    required this.conditionCode,
    required this.isDayTime,
    this.size = 64.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData = getWeatherIcon(conditionCode, isDayTime);

    return BoxedIcon(
      iconData,
      size: size,
      color: color,
    );
  }
}
