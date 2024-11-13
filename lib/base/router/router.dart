import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/Base/Router/routes.dart';
import 'package:meteo_app_notification/Base/layout/layou_scaffold.dart';
import 'package:meteo_app_notification/settings/ui/screens/settings/settings_page.dart';
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
