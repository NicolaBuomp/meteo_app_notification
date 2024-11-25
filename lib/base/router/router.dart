// lib/base/router/router.dart
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/auth/ui/screens/auth_page.dart';
import 'package:meteo_app_notification/auth/ui/screens/login_page.dart';
import 'package:meteo_app_notification/auth/ui/screens/register_page.dart';
import 'package:meteo_app_notification/base/layout/layout_scaffold.dart';
import 'package:meteo_app_notification/favorite/ui/screens/favorite_page.dart';
import 'package:meteo_app_notification/settings/ui/screens/settings/settings_page.dart';
import 'package:meteo_app_notification/weather/ui/screens/weather_details_page.dart';
import 'package:meteo_app_notification/weather/ui/screens/weather_page.dart';

GoRouter router(bool isAuthenticated) {
  return GoRouter(
    initialLocation: Routes.weatherPage,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation.startsWith('/auth');

      if (!isAuthenticated && !isLoggingIn) {
        // L'utente non è autenticato e cerca di accedere a una pagina protetta
        return Routes.authPage;
      }

      if (isAuthenticated && isLoggingIn) {
        // L'utente è autenticato ma cerca di accedere alla pagina di login/registrazione
        return Routes.weatherPage;
      }

      // Nessun reindirizzamento necessario
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.authPage,
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => RegisterPage(),
          ),
        ],
      ),
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
                path: Routes.favoritePage,
                builder: (context, state) => const FavoritePage(),
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
}

class Routes {
  static const String authPage = '/auth';
  static const String weatherPage = '/weather';
  static const String weatherDetailsWithId = '/weather/details/:lat/:long';
  static const String favoritePage = '/favorite';
  static const String settingsPage = '/settings';
}
