import 'dart:async';
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
    _spawnManyDialogs();
  }

  Future<void> _spawnManyDialogs() async {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      _runOneDialogFlow(i);
    }
  }

  Future<void> _runOneDialogFlow(int i) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: Text('팝업 $i'),
          content: Text('이것은 $i번째 팝업입니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      print("확인화면확인화면확인화면");
      print(i);
      context.go('/b');
    } else {
      print("취소화면취소화면취소화면");
      print(i);
      context.go('/a');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('팝업 연속 테스트 화면')));
  }
}
