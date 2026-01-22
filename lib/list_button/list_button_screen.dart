import 'package:flutter/material.dart';

class ListButtonScreen extends StatelessWidget {
  const ListButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const listLength = 4;
    final myList = [1, 2];
    final registeredCount = myList.length;

    return Scaffold(
      appBar: AppBar(title: const Text('리스트 버튼')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < listLength; i++) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    i < registeredCount
                        ? Colors.green
                        : (i == registeredCount ? Colors.blue : Colors.grey),
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    i < registeredCount
                        ? Colors.green
                        : (i == registeredCount ? Colors.blue : Colors.grey),
                disabledForegroundColor: Colors.white,
              ),
              onPressed:
                  (i > registeredCount)
                      ? null
                      : () {
                        if (i == registeredCount) {
                          print('기기 추가 가능');
                        } else {
                          print('등록된 기기');
                        }
                      },
              child:
                  i < registeredCount
                      ? Text('내 기기 ${i + 1}')
                      : const Icon(Icons.add, color: Colors.white),
            ),
            if (i != listLength - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
