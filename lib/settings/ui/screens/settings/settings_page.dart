import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/settings/ui/widgets/clear_data_section.dart';
import 'package:meteo_app_notification/settings/ui/widgets/language_selection_section.dart';
import 'package:meteo_app_notification/settings/ui/widgets/theme_selection_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).settings.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClearDataSection(),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            SizedBox(
              height: 8,
            ),
            ThemeSelectionSection(),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            SizedBox(
              height: 8,
            ),
            LanguageSelectionSection(),
          ],
        ),
      ),
    );
  }
}
