import 'package:flutter/material.dart';
import 'package:airbridge_flutter_sdk/airbridge_flutter_sdk.dart';
import 'go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Airbridge.setOnDeeplinkReceived((deeplink) {
    print('Airbridge deeplink: $deeplink');
    final uri = Uri.tryParse(deeplink);
    if (uri == null) return;

    final uriStr = uri.toString();
    final code = uri.queryParameters['code'];

    print("남인우 바보$uriStr");
    print("남인우 메롱$code");

    // 0.5초 대기 후 goRouter 사용
    Future.delayed(const Duration(milliseconds: 500), () {
      goRouter.go('/code?code=$code');
    });

    print("통과함통과함통과함통과함통과함");
  });

  print("MyApp이 실행됨");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}
