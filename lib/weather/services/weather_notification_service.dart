import 'package:meteo_app_notification/weather/data/models/models.dart';
import '../../services/notifications/local_notifications_services.dart';
import 'package:intl/intl.dart';

class TimeInterval {
  final DateTime start;
  final DateTime end;

  TimeInterval({required this.start, required this.end});
}

class WeatherNotificationService {
  final LocalNotificationsService _localNotificationsService;

  WeatherNotificationService(this._localNotificationsService);

  Future<void> checkDailyRain(WeatherModel weather) async {
    try {
      final dailyForecast = weather.forecast.first;

      List<HourlyForecast> highRainHours = [];
      final now = DateTime.now();

      for (final hour in dailyForecast.hourly) {
        final currentTime =
            DateTime.fromMillisecondsSinceEpoch(hour.timeEpoch * 1000)
                .toLocal();

        if (currentTime.isAfter(now) || _isSameHour(currentTime, now)) {
          if (hour.chanceOfRain >= 70) {
            highRainHours.add(hour);
          }
        }
      }

      if (highRainHours.isNotEmpty) {
        // Trova gli intervalli di ore consecutive con alta probabilità di pioggia
        List<TimeInterval> rainIntervals = _findRainIntervals(highRainHours);

        if (rainIntervals.isNotEmpty) {
          // Costruisci il messaggio della notifica
          String notificationMessage = _buildNotificationMessage(rainIntervals);

          // Mostra la notifica
          await _localNotificationsService.showInstantNotification(
            'Attenzione',
            notificationMessage,
          );
        }
      } else {
        // Non ci sono ore future con alta probabilità di pioggia
        await _localNotificationsService.showInstantNotification(
          'Giornata tranquilla',
          'Oggi non sono previste piogge significative. Goditi la giornata!',
        );
      }
    } catch (e) {
      print('Errore durante il controllo della pioggia: $e');
    }
  }

  // Funzione per trovare gli intervalli di ore consecutive
  List<TimeInterval> _findRainIntervals(List<HourlyForecast> highRainHours) {
    List<TimeInterval> intervals = [];

    if (highRainHours.isEmpty) return intervals;

    // Ordina le ore per tempo (nel caso non siano già ordinate)
    highRainHours.sort((a, b) => a.timeEpoch.compareTo(b.timeEpoch));

    DateTime? intervalStart;
    DateTime? intervalEnd;

    for (int i = 0; i < highRainHours.length; i++) {
      final currentHour = highRainHours[i];
      final currentTime =
          DateTime.fromMillisecondsSinceEpoch(currentHour.timeEpoch * 1000)
              .toLocal();

      if (intervalStart == null) {
        // Inizia un nuovo intervallo
        intervalStart = currentTime;
        intervalEnd = currentTime;
      } else {
        // Verifica se l'ora corrente è consecutiva all'ora precedente
        final previousHour = highRainHours[i - 1];
        final previousTime =
            DateTime.fromMillisecondsSinceEpoch(previousHour.timeEpoch * 1000)
                .toLocal();

        if (currentTime.difference(previousTime).inHours == 1) {
          // L'ora corrente è consecutiva; estende l'intervallo
          intervalEnd = currentTime;
        } else {
          // L'ora corrente non è consecutiva; salva l'intervallo precedente
          intervals.add(TimeInterval(start: intervalStart, end: intervalEnd!));

          // Inizia un nuovo intervallo
          intervalStart = currentTime;
          intervalEnd = currentTime;
        }
      }

      // Se siamo all'ultima iterazione, aggiungi l'intervallo corrente
      if (i == highRainHours.length - 1) {
        intervals.add(TimeInterval(start: intervalStart, end: intervalEnd));
      }
    }

    return intervals;
  }

  // Funzione per costruire il messaggio della notifica
  String _buildNotificationMessage(List<TimeInterval> intervals) {
    if (intervals.isEmpty) {
      return 'Oggi non sono previste piogge significative.';
    }

    String message = 'Oggi è prevista pioggia ';

    final DateFormat hourFormat = DateFormat('HH:mm');

    for (int i = 0; i < intervals.length; i++) {
      final interval = intervals[i];
      final startHour = hourFormat.format(interval.start);
      final endHour = hourFormat.format(interval.end);

      if (interval.start.hour == interval.end.hour) {
        // Se l'intervallo è di un'ora sola
        message += 'alle ore $startHour';
      } else {
        message += 'dalle $startHour alle $endHour';
      }

      if (i < intervals.length - 1) {
        message += ', ';
      } else {
        message += '.';
      }
    }

    return message;
  }

  // Funzione per verificare se due DateTime sono nella stessa ora
  bool _isSameHour(DateTime time1, DateTime time2) {
    return time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day &&
        time1.hour == time2.hour;
  }
}
