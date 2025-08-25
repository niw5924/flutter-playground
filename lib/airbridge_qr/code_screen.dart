import 'package:flutter/material.dart';

/// 앱링크로 들어온 code를 보여주는 전용 화면
class CodeScreen extends StatelessWidget {
  final String code;
  final String fullUri;

  const CodeScreen({super.key, required this.code, required this.fullUri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Link Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              code,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                fullUri,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
