import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/favorite/ui/widgets/fovorite_city_list.dart';
import 'package:meteo_app_notification/favorite/di/favorite_city_provider.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

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
    final cityInfoViewModel = ref.read(cityInfoViewModelProvider.notifier);
    final asyncFavoriteCities = ref.watch(cityInfoViewModelProvider);

    final hasFavoriteCities = asyncFavoriteCities.maybeWhen(
      data: (cities) => cities.isNotEmpty,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Città Preferite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: hasFavoriteCities
                ? () => _confirmDelete(
                      context,
                      () => cityInfoViewModel.removeAll(),
                    )
                : null,
            color: Colors.red,
            iconSize: 30,
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: FavoriteCityList(),
      ),
    );
  }
}
