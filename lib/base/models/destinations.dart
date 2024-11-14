import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.translationKey, required this.icon});

  final String translationKey;
  final IconData icon;
}

const destinations = [
  Destination(translationKey: 'weather', icon: Icons.home_rounded),
  Destination(translationKey: 'impostazioni', icon: Icons.settings_rounded),
];
