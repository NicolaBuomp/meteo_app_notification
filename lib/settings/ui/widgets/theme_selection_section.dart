import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/base/viewmodel/theme_viewmodel.dart';

class ThemeSelectionSection extends ConsumerWidget {
  const ThemeSelectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeViewModelProvider);
    final themeViewModel = ref.read(themeViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translation.settings.theme.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RadioListTile<ThemeMode>(
          title: Text(
            context.translation.settings.theme.light,
          ),
          value: ThemeMode.light,
          groupValue: themeMode,
          onChanged: (value) {
            if (value != null) {
              themeViewModel.setLightMode();
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(
            context.translation.settings.theme.dark,
          ),
          value: ThemeMode.dark,
          groupValue: themeMode,
          onChanged: (value) {
            if (value != null) {
              themeViewModel.setDarkMode();
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(
            context.translation.settings.theme.system,
          ),
          value: ThemeMode.system,
          groupValue: themeMode,
          onChanged: (value) {
            if (value != null) {
              themeViewModel.setSystemMode();
            }
          },
        ),
      ],
    );
  }
}
