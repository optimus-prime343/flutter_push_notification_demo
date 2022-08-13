import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/screens/home_screen.dart';
import 'package:flutter_push_notification/screens/notification_screen.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/cipher_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'cipher_basic_channel',
        channelName: 'Cipher Basic Notifications',
        channelDescription: 'Cipher notification channel for basic test',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cipher',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        NotificationScreen.routeName: (context) => const NotificationScreen(),
      },
    );
  }
}
