import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class KakaoLoginScreen extends StatefulWidget {
  const KakaoLoginScreen({super.key});

  @override
  State<KakaoLoginScreen> createState() => _KakaoLoginScreenState();
}

class _KakaoLoginScreenState extends State<KakaoLoginScreen> {
  String? _code; // 로그인 결과 저장
  String? _state; // state 저장

  Future<void> _login() async {
    const authUrl = 'http://192.168.35.85:8080/oauth2/authorization/kakao';
    const callbackScheme = 'kakao';

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackScheme,
      );

      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];
      final state = uri.queryParameters['state'];

      setState(() {
        _code = code;
        _state = state;
      });
    } catch (e) {
      setState(() {
        _code = null;
        _state = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: _login, child: const Text('카카오 로그인')),
            const SizedBox(height: 20),
            if (_code != null) Text("Code: $_code"),
            if (_state != null) Text("State: $_state"),
            if (_code == null && _state == null) const Text("아직 로그인하지 않았습니다."),
          ],
        ),
      ),
    );
  }
}
