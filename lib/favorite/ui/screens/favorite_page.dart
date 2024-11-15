import 'package:flutter/material.dart';
import 'package:meteo_app_notification/favorite/ui/widgets/fovorite_city_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Città Preferite'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: FavoriteCityList(),
      ),
    );
  }
}
