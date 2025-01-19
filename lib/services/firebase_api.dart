import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';
import '../screens/random_joke_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    print("Navigate to Random Joke Screen...");
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(RandomJokeScreen.route);
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('#################################################################');
    print('#################################################################');
    print('Token: $fCMToken');
    print('#################################################################');
    print('#################################################################');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}