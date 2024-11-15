import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/Base/widgets/custom_snack_bar.dart';
import 'package:meteo_app_notification/i18n/translations.dart';
import 'package:meteo_app_notification/weather/di/city_info_provider.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class ClearDataSection extends ConsumerWidget {
  const ClearDataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);
    final cityInfoViewModel = ref.read(cityInfoViewModelProvider.notifier);

    Future<void> clearData({
      required Future<void> Function() clearFunction,
      required String successMessage,
      IconData icon = Icons.info,
      Color backgroundColor = Colors.green,
    }) async {
      try {
        await clearFunction();
        CustomSnackBar.show(
          context,
          message: successMessage,
          backgroundColor: backgroundColor,
          icon: icon,
        );
      } catch (error) {
        CustomSnackBar.show(
          context,
          message: 'error',
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => clearData(
            clearFunction: weatherViewModel.clearWeatherData,
            successMessage:
                context.translation.settings.actions.clear_weather_confirmation,
            icon: Icons.cloud_off,
          ),
          child: Text(
            context.translation.settings.actions.clear_weather,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => clearData(
            clearFunction: cityInfoViewModel.removeAll,
            successMessage: context
                .translation.settings.actions.clear_favorites_confirmation,
            icon: Icons.favorite_border,
          ),
          child: Text(
            context.translation.settings.actions.clear_favorites,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await clearData(
              clearFunction: () async {
                await weatherViewModel.clearWeatherData();
                await cityInfoViewModel.removeAll();
              },
              successMessage:
                  context.translation.settings.actions.clear_all_confirmation,
              icon: Icons.delete_forever,
              backgroundColor: Colors.red,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            context.translation.settings.actions.clear_all,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
