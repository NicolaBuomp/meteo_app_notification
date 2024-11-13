import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/router/router.dart';
import 'package:meteo_app_notification/base/theme/app_theme.dart';
import 'package:meteo_app_notification/base/viewmodel/theme_viewmodel.dart';
import 'package:meteo_app_notification/i18n/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeViewModelProvider);

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
          locale: TranslationProvider.of(context)
              .flutterLocale, // Aggiorna locale dinamicamente
        ),
      ),
    );
  }
}
