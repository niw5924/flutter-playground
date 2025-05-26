import 'package:flutter/material.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("위젯 테스트")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("버튼 눌렸음");
            },
            child: Text("버튼"),
          ),
        ],
      ),
    );
  }
}
