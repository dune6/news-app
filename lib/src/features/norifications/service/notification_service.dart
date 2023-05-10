import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:rxdart/rxdart.dart';

/// Notification service pushes, use [NotificationService()]
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// stream controller for handle payload in pushes
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (payload != null && payload.isNotEmpty) {
        behaviorSubject.add(payload);
      }
    });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  /// A method for create push
  Future showArticleNotification(
      {int id = 0, required Article article, String? payload}) async {
    return notificationsPlugin.show(
        id, article.title, article.abstract, await notificationDetails(),
        payload: jsonEncode(article));
  }
}
