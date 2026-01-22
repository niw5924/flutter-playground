import 'package:flutter/material.dart';

class ListButtonScreen extends StatelessWidget {
  const ListButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listLength = 4;
    final myList = [1, 2];

    return Scaffold(
      appBar: AppBar(title: const Text('리스트 버튼')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < listLength; i++) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (i < myList.length) ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (i == myList.length) {
                    print("기기 추가 가능");
                  } else {
                    print("기기 추가 불가능");
                  }
                },
                child: Text('내 기기 ${i + 1}'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
