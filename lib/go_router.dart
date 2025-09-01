import 'package:flutter_niw/airbridge_qr/airbridge_qr_screen.dart';
import 'package:go_router/go_router.dart';
import 'popup_sequence/screen_a.dart';
import 'popup_sequence/screen_b.dart';
import 'airbridge_qr/code_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AirbridgeQrScreen()),
    GoRoute(path: '/a', builder: (context, state) => const ScreenA()),
    GoRoute(path: '/b', builder: (context, state) => const ScreenB()),
    GoRoute(
      path: '/code',
      builder: (context, state) {
        final code = state.uri.queryParameters['code']!;
        final fullUri = state.uri.toString();
        return CodeScreen(code: code, fullUri: fullUri);
      },
    ),
  ],
);
