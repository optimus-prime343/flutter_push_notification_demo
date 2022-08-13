import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final action = ModalRoute.of(context)?.settings.arguments as ReceivedAction;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Detail '),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  action.title ?? '',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  action.body ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 2,
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
