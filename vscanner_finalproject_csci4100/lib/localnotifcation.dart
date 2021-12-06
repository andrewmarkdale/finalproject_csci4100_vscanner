import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class SimpleNotification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  SimpleNotification(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/vegescanner');
    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<String?> selectNotification(String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Product saved"),
              content: Text("Your product was saved successfully."),
            ));
  }

  Future showNotification(bool successOrFail) async {
    var android = AndroidNotificationDetails("channelId", "channelName",
        successOrFail ? "Save success" : "Save failed",
        priority: Priority.high, importance: Importance.max);
    var platformDetails = NotificationDetails(android: android);
    await notification.show(
        100,
        successOrFail ? "Save success" : "Save failed",
        successOrFail
            ? "Your product was saved!"
            : "Your product was not saved.",
        platformDetails,
        payload: "a demo payload");
  }
}
