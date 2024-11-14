import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/di/language_viewmodel.dart';
import 'package:meteo_app_notification/i18n/translations.dart';

class LanguageSelectionSection extends ConsumerWidget {
  const LanguageSelectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageViewModelProvider);
    final localeNotifier = ref.read(languageViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          translation.settings.language.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RadioListTile<AppLocale>(
          title: Text(
            translation.settings.language.italian,
            style: TextStyle(color: Colors.white),
          ),
          value: AppLocale.it,
          groupValue: currentLocale,
          onChanged: (locale) {
            if (locale != null) {
              localeNotifier.setLocale(locale);
            }
          },
        ),
        RadioListTile<AppLocale>(
          title: Text(
            translation.settings.language.english,
            style: TextStyle(color: Colors.white),
          ),
          value: AppLocale.en,
          groupValue: currentLocale,
          onChanged: (locale) {
            if (locale != null) {
              localeNotifier.setLocale(locale);
            }
          },
        ),
      ],
    );
  }
}
