import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      // 0.5초 대기 후 팝업 표시
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // 팝업 띄우기
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            title: Text('팝업 $i'),
            content: Text('이것은 $i번째 팝업입니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go('/a');
                },
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go('/b');
                },
                child: const Text('확인'),
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
