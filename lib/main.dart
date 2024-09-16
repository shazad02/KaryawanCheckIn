import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile2karyawan/navigator/navigator_screen.dart';
import 'package:mobile2karyawan/notification/notif.dart';
import 'package:mobile2karyawan/notification/testnotif.dart';
import 'package:mobile2karyawan/views/screens/regiscontoh.dart';
import 'package:mobile2karyawan/views/screens/registerscreen/register_screen.dart';
import 'package:mobile2karyawan/views/screens/spaslashscreen/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "basic_channel_group",
      channelKey: "basic_channel",
      channelName: "Basic Notification",
      channelDescription: "Basic notifications channel",
    )
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: "basic_channel_group",
      channelGroupName: "Basic group",
    )
  ]);
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  scheduleNotifications();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const RegisterScreen(),
      home: StreamBuilder<User?>(
        stream: MyApp.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              // Pengguna tidak masuk
              // Navigasi ke layar masuk atau tampilkan konten sesuai kebutuhan
              return const SplashScreen(); // Contoh: Navigasi ke layar masuk
            } else {
              // Pengguna berhasil masuk
              // Lanjutkan dengan konten aplikasi yang sesuai
              return const NavigatorScreen(); // Contoh: Navigasi ke layar utama
            }
          }
          return const CircularProgressIndicator(); // atau widget lain yang sesuai
        },
      ),
    );
  }
}

void scheduleNotifications() async {
  DateTime now = DateTime.now();
  int hour = now.hour;

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: 'Reminder',
      body: 'Ayo Absen Dahulu sudah jam $hour, Absen Di tutup jam 08.30',
    ),
    schedule: NotificationCalendar(
      timeZone: "Asia/Singapore",
      allowWhileIdle: true,
      hour: 8,
      minute: 0,
      second: 0,
      repeats: true,
    ),
  );
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 2,
      channelKey: 'basic_channel',
      title: 'Reminder',
      body: 'Ayo Absen Dahulu sudah jam $hour, Absen Di tutup jam 04.30',
    ),
    schedule: NotificationCalendar(
      timeZone: "Asia/Singapore",
      allowWhileIdle: true,
      hour: 16,
      minute: 0,
      second: 0,
      repeats: true,
    ),
  );
}
