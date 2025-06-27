import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_detail_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotification();
  }

  void _initializeNotification() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'navigate') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationDetailPage()),
          );
        }
      },
    );
  }

  void _showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      '기본 채널',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      '테스트 알림',
      '클릭하면 이동합니다.',
      notificationDetails,
      payload: 'navigate',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알림 예제')),
      body: Center(
        child: ElevatedButton(
          onPressed: _showNotification,
          child: const Text('알림 보내기'),
        ),
      ),
    );
  }
}
