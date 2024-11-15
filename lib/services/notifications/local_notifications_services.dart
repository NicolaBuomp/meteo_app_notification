import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class LocalNotificationsService {
// Singleton
  static final LocalNotificationsService _instance =
      LocalNotificationsService._internal();
  factory LocalNotificationsService() => _instance;
  LocalNotificationsService._internal();
// Plugin delle notifiche
  FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
// Plugin delle notifiche
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
// Inizializzazione delle timezone
    tz.initializeTimeZones();
// Impostazioni per Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
// Impostazioni per iOS
    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'test',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('test', 'This is a test'),
          ],
        ),
      ],
    );
    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
// Inizializzazione del plugin
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: handleNotificationClick,
      onDidReceiveBackgroundNotificationResponse: handleNotificationClick,
    );
// Controlla se l'app è stata avviata da una notifica
    final details =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      if (details?.notificationResponse != null) {
        await handleNotificationClick(details!.notificationResponse!);
      }
    }
  }

// Metodo per gestire il click sulla notifica
  @pragma('vm:entry-point')
  static Future<void> handleNotificationClick(
      NotificationResponse response) async {
    if (response.payload != null) {
      final data = json.decode(response.payload!);
      if (data['link'] != null) {
        launchUrl(Uri.parse(data['link']));
      }
    }
  }

// Metodo per inviare una notifica istantanea
  Future<void> showInstantNotification(String title, String body,
      {String? payload}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'instant_channel',
      'Notifiche Istantanee',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _notificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

// Metodo per inviare una notifica programmata
  Future<void> scheduleNotification(String title, String body, Duration delay,
      {String? payload}) async {
    await _notificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Notifiche Programmate',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
}
