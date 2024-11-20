import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/router/router.dart';
import 'package:meteo_app_notification/base/theme/app_theme.dart';
import 'package:meteo_app_notification/base/viewmodel/theme_viewmodel.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/services/notifications/local_notifications_services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inizializzazione del database dei fusi orari
  tz.initializeTimeZones();

  // Inizializzazione del servizio notifiche
  await LocalNotificationsService().initialize();

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeViewModelProvider);

    // Aggiorna dinamicamente lo stile della status bar quando il tema cambia
    _updateStatusBarStyle(themeMode);

    return TranslationProvider(
      child: Builder(
        builder: (context) => MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          locale: TranslationProvider.of(context).flutterLocale,
        ),
      ),
    );
  }

  void _updateStatusBarStyle(ThemeMode themeMode) {
    final SystemUiOverlayStyle overlayStyle = themeMode == ThemeMode.dark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          );

    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }
}
