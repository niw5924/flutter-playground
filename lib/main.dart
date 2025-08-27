// import 'package:flutter/material.dart';
// import 'package:flutter_niw/airbridge_qr/airbridge_qr_screen.dart';
// import 'package:flutter_niw/airbridge_qr/code_screen.dart';
// import 'package:airbridge_flutter_sdk/airbridge_flutter_sdk.dart';
//
// final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   Airbridge.setOnDeeplinkReceived((deeplink) {
//     debugPrint('Airbridge deeplink: $deeplink');
//     final uri = Uri.tryParse(deeplink);
//     if (uri == null) return;
//
//     final uriStr = uri.toString();
//     final code = uri.queryParameters['code'];
//     if (code == null || code.isEmpty) return;
//
//     debugPrint("남인우 바보$uriStr");
//     debugPrint("남인우 메롱$code");
//
//     // 0.5초 대기 후 push
//     Future.delayed(const Duration(milliseconds: 500), () {
//       _navKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (_) => CodeScreen(code: code, fullUri: uriStr),
//         ),
//       );
//     });
//
//     print("통과함통과함통과함통과함통과함");
//   });
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(navigatorKey: _navKey, home: const AirbridgeQrScreen());
//   }
// }

import 'package:flutter/material.dart';
import 'go_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}
