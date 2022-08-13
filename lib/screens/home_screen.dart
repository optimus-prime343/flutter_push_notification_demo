import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/services/notification_service.dart';

import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final StreamSubscription<ReceivedAction> streamSubscription;

  @override
  void initState() {
    super.initState();
    // check for notification permission and asks for notification permission if it is not allowed by default
    AwesomeNotifications().isNotificationAllowed().then(
      (isNotificationAllowed) {
        if (!isNotificationAllowed) {
          showDialog(
            context: context,
            builder: (context) => const AllowNotificationsDialog(),
          );
        }
      },
    );
    // listens for the notifications and redirects to the notification page
    streamSubscription = AwesomeNotifications().actionStream.listen((event) {
      Navigator.of(context).pushNamed(
        NotificationScreen.routeName,
        arguments: event,
      );
    });
  }

  @override
  void dispose() {
    // clears the subscription on widget unmount
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showNotification() async {
      final data = await NotificationService.getNotificationContent();
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: data.id,
          channelKey: 'cipher_basic_channel',
          title: data.title,
          body: data.body,
          color: Colors.orange,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: showNotification,
          icon: const Icon(Icons.notification_add),
          color: Theme.of(context).primaryColor,
        ),
        appBar: AppBar(
          title: const Text('Flutter Push Notification'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Tap the button below to show a notification',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class AllowNotificationsDialog extends StatelessWidget {
  const AllowNotificationsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Allow notification permission'),
      content: const Text('Would you like to allow us to send notifications ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Dont allow'),
        ),
        TextButton(
          onPressed: () {
            AwesomeNotifications().requestPermissionToSendNotifications().then(
                  (value) => Navigator.of(context).pop(),
                );
          },
          child: const Text('Allow'),
        )
      ],
    );
  }
}
