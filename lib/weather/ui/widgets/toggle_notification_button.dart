import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/base/widgets/custom_snack_bar.dart';
import 'package:meteo_app_notification/weather/viewmodel/weather_viewmodel.dart';

class ToggleNotificationButton extends ConsumerStatefulWidget {
  final String city;
  final double iconSize;

  const ToggleNotificationButton({
    super.key,
    required this.city,
    required this.iconSize,
  });

  @override
  _ToggleNotificationButtonState createState() =>
      _ToggleNotificationButtonState();
}

class _ToggleNotificationButtonState
    extends ConsumerState<ToggleNotificationButton> {
  bool _notificationSent = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _notificationSent ? 'Notifica già inviata' : 'Invia notifica',
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            _notificationSent
                ? Icons.notifications_active_outlined
                : Icons.notifications,
            key: ValueKey<bool>(_notificationSent),
            color: Colors.yellow.shade600,
            size: widget.iconSize,
          ),
        ),
        onPressed: _notificationSent
            ? null
            : () async {
                setState(() {
                  _notificationSent = true;
                });

                try {
                  await ref
                      .read(weatherViewModelProvider.notifier)
                      .dailyRainCheck();

                  CustomSnackBar.show(
                    context,
                    message: 'Notifica inviata per "${widget.city}"',
                    backgroundColor: Colors.green,
                    icon: Icons.notifications_active_rounded,
                  );
                } catch (e) {
                  CustomSnackBar.show(
                    context,
                    message: 'Errore: ${e.toString()}',
                    backgroundColor: Colors.red,
                    icon: Icons.error,
                  );
                  setState(() {
                    _notificationSent = false;
                  });
                } finally {
                  Future.delayed(const Duration(seconds: 7), () {
                    if (mounted) {
                      setState(() {
                        _notificationSent = false;
                      });
                    }
                  });
                }
              },
      ),
    );
  }
}
