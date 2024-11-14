import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatelessWidget {
  final String? latitude;
  final String? longitude;

  const WeatherDetailsPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Latitudine: $latitude, Longitudine: $longitude',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
