import 'package:flutter/material.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알림 상세 페이지')),
      body: const Center(
        child: Text('알림을 클릭해서 이동한 페이지입니다.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
