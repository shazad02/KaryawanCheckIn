import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class TestNotif extends StatefulWidget {
  const TestNotif({super.key});

  @override
  State<TestNotif> createState() => _TestNotifState();
}

class _TestNotifState extends State<TestNotif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Notif"),
          ),
          TextButton(
            onPressed: () {
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: 1,
                      channelKey: "basic_channel",
                      title: "Test",
                      body: "OK"));
            },
            child: const Text("data"),
          )
        ],
      ),
    );
  }
}
