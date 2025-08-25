import 'package:flutter/material.dart';
import 'package:flutter_niw/airbridge_qr/airbridge_qr_screen.dart';
import 'package:flutter_niw/airbridge_qr/code_screen.dart';
import 'package:airbridge_flutter_sdk/airbridge_flutter_sdk.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    // 1) 딥링크 콜백: 설치된 상태 + 지연 딥링크 모두 여기로 옴
    Airbridge.setOnDeeplinkReceived((deeplink) {
      debugPrint('Airbridge deeplink: $deeplink');
      final uri = Uri.tryParse(deeplink);
      if (uri == null) return;
      _handleUri(uri);
      print("통과함통과함통과함통과함통과함");
    });
  }

  void _handleUri(Uri uri) {
    final uriStr = uri.toString();

    // 원하는 파라미터 추출
    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) return;

    // 네비게이터 준비 이후 화면 전환
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _navKey.currentState?.overlay?.context;
      if (ctx == null) return;
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) => CodeScreen(code: code, fullUri: uriStr),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(navigatorKey: _navKey, home: const AirbridgeQrScreen());
  }
}
