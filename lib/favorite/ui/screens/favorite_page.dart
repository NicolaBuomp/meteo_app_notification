import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/ui/widgets/fovorite_city_list.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';
import 'package:meteo_app_notification/Base/widgets/custom_snack_bar.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  /// Mostra una finestra di dialogo per confermare l'eliminazione di tutte le città preferite.
  void _confirmDelete(BuildContext context, VoidCallback actions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conferma Eliminazione'),
          content: const Text(
              'Sei sicuro di voler eliminare tutte le città preferite?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                actions();
                Navigator.of(context).pop();
              },
              child: const Text('Elimina'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityInfoState = ref.watch(favoriteCityViewModelProvider);
    final cityInfoNotifier = ref.read(favoriteCityViewModelProvider.notifier);

    final hasFavoriteCities = cityInfoState.cities.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Città Preferite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: hasFavoriteCities
                ? () => _confirmDelete(
                      context,
                      () async {
                        await cityInfoNotifier.removeAll();
                        CustomSnackBar.show(
                          context,
                          message:
                              'Tutte le città preferite sono state eliminate.',
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        );
                      },
                    )
                : null,
            color: Colors.red,
            iconSize: 30,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: cityInfoState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const FavoriteCityList(),
      ),
    );
  }
}
