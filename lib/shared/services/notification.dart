import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../constants/string_constants.dart';

class NotificationHandler {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationHandler() {
    // initializeFcmNotification();
    createNotificationChannel();
    setListeners();
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void unSubcribe() {
    try {
      messaging.unsubscribeFromTopic("notification_cms_okokadex").then(print);
    } catch (e) {
      print(e);
    }
  }

  void setListeners() {
    try {
      messaging.subscribeToTopic("notification_cms_okokadex").then(print);
    } catch (e) {
      print(e);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print('Message data: ${message.data}');

      try {
        if (message.notification != null) {
          print('Message title: ${message.notification!.title}');
          print('Message body: ${message.notification!.body}');

          flutterLocalNotificationsPlugin.show(
            0,
            message.notification?.title,
            message.notification?.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'dream',
                'Dream Travel',
                priority: Priority.high,
                importance: Importance.max,
                playSound: true,
              ),
              // iOS: IOSNotificationDetails(
              //   sound: 'default',
              // ),
            ),
          );
        }
      } catch (e) {
        Get.snackbar(StringConst.error.tr, "$e");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published! ${message.data}');
    });
  }

  void createNotificationChannel() async {
    if (Platform.isAndroid) {
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        'Dream',
        'Dream Travel',
        importance: Importance.max,
        playSound: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }
}
