import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/i18n/translations.dart';

class LanguageViewModel extends StateNotifier<AppLocale> {
  LanguageViewModel() : super(AppLocale.it);

  void setLocale(AppLocale locale) {
    state = locale;
    LocaleSettings.setLocale(locale);
  }

  AppLocale get currentLocale => state;
}

final languageViewModelProvider =
    StateNotifierProvider<LanguageViewModel, AppLocale>((ref) {
  return LanguageViewModel();
});
