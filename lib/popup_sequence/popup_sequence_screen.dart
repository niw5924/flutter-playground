import 'package:flutter/material.dart';

class PopupSequenceScreen extends StatefulWidget {
  const PopupSequenceScreen({super.key});

  @override
  State<PopupSequenceScreen> createState() => _PopupSequenceScreenState();
}

class _PopupSequenceScreenState extends State<PopupSequenceScreen> {
  @override
  void initState() {
    super.initState();
    _showPopupsSequentially();
  }

  Future<void> _showPopupsSequentially() async {
    for (int i = 1; i <= 5; i++) {
      // 0.5초 대기
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            title: Text('팝업 $i'),
            content: Text('이것은 $i번째 팝업입니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('팝업 연속 테스트 화면')));
  }
}
