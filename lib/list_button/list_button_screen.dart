import 'package:flutter/material.dart';

class ListButtonScreen extends StatelessWidget {
  const ListButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ['A', 'B', 'C', 'D'];

    return Scaffold(
      appBar: AppBar(title: const Text('리스트 버튼')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (String s in list) ...[
              ElevatedButton(onPressed: null, child: Text(s)),
            ],
          ],
        ),
      ),
    );
  }
}
