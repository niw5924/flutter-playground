import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인 배경화면')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/image/image1.jpg', fit: BoxFit.cover),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('네이버 로그인 시도');
                },
                child: const Text('네이버 로그인'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  print('카카오 로그인 시도');
                },
                child: const Text('카카오 로그인'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
