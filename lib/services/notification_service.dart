import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../models/app_settings.dart';

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  bool get _isSupported {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS || Platform.isMacOS || Platform.isLinux;
  }

  Future<void> init() async {
    if (!_isSupported || _initialized) return;

    tz_data.initializeTimeZones();
    final tzName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzName));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));
    _initialized = true;
  }

  Future<void> requestPermissions() async {
    if (!_isSupported) return;
    if (!_initialized) await init();

    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  Future<void> cancelAll() async {
    if (!_isSupported) return;
    await _plugin.cancelAll();
  }

  Future<void> scheduleReminders(AppSettings settings) async {
    if (!_isSupported) return;
    if (!_initialized) await init();

    await cancelAll();
    if (!settings.reminderEnabled) return;

    final wakeMinutes = _parseTimeToMinutes(settings.wakeUpTime, fallback: 7 * 60);
    final bedMinutes = _parseTimeToMinutes(settings.bedTime, fallback: 23 * 60);

    const androidDetails = AndroidNotificationDetails(
      'water_reminders',
      'Water Reminders',
      channelDescription: 'Hydration reminder notifications',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    int id = 0;
    int current = wakeMinutes;

    while (current <= bedMinutes && id < 60) {
      final hour = current ~/ 60;
      final minute = current % 60;
      try {
        await _plugin.zonedSchedule(
          id,
          '💧 Time to hydrate!',
          'Stay on track with your daily water goal.',
          _nextInstanceOfTime(hour, minute),
          details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (_) {
        await _plugin.zonedSchedule(
          id,
          '💧 Time to hydrate!',
          'Stay on track with your daily water goal.',
          _nextInstanceOfTime(hour, minute),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
      current += settings.reminderInterval;
      id++;
    }

    // Custom one-off daily notifications (IDs 100+)
    int customId = 100;
    for (final time in settings.customTimes) {
      final parts = time.split(':');
      if (parts.length != 2) continue;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;
      try {
        await _plugin.zonedSchedule(
          customId,
          '💧 Time to hydrate!',
          'Stay on track with your daily water goal.',
          _nextInstanceOfTime(hour, minute),
          details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (_) {
        await _plugin.zonedSchedule(
          customId,
          '💧 Time to hydrate!',
          'Stay on track with your daily water goal.',
          _nextInstanceOfTime(hour, minute),
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
      customId++;
    }
  }

  int _parseTimeToMinutes(String time, {required int fallback}) {
    final parts = time.split(':');
    if (parts.length != 2) return fallback;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return fallback;
    return h * 60 + m;
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
