import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meteo_app_notification/Base/models/destinations.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24), // Bordi arrotondati
            child: Container(
              height: 80,
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: destinations.map((destination) {
                  final bool isSelected = destinations.indexOf(destination) ==
                      navigationShell.currentIndex;
                  return GestureDetector(
                    onTap: () => navigationShell
                        .goBranch(destinations.indexOf(destination)),
                    child: AnimatedContainer(
                      duration: const Duration(
                          milliseconds: 300), // Animazione più lunga
                      curve: Curves.easeInOut, // Curva più fluida
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              switchInCurve: Curves.easeInOut,
                              switchOutCurve: Curves.easeInOut,
                              child: Icon(
                                destination.icon,
                                key: ValueKey<bool>(isSelected),
                                color: isSelected
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.5),
                                size: isSelected
                                    ? 28
                                    : 24, // Differenza dimensione
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: isSelected
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        destination.translationKey,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
}
