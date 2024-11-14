import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/base/layout/layout_scaffold.dart';
import 'package:meteo_app_notification/settings/ui/screens/settings/settings_page.dart';
import 'package:meteo_app_notification/weather/ui/screens/weather_details/weather_details_page.dart';
import 'package:meteo_app_notification/weather/ui/screens/weather_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.weatherPage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.weatherPage,
              builder: (context, state) => const WeatherPage(),
            ),
            GoRoute(
              path: Routes.weatherDetailsWithId,
              builder: (context, state) {
                final lat = state.pathParameters['lat'];
                final long = state.pathParameters['long'];
                return WeatherDetailsPage(latitude: lat, longitude: long);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingsPage,
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class Routes {
  static const String weatherPage = '/weatherPage';
  static const String weatherDetailsWithId = '/weatherDetails/:lat/:long';
  static const String settingsPage = '/settings';
}
