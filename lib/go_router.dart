import 'package:go_router/go_router.dart';

import 'airbridge_qr/airbridge_qr_screen.dart';
import 'airbridge_qr/code_screen.dart';
import 'comment_panel/comment_panel_screen.dart';
import 'login_background/login_background_screen.dart';
import 'popup_sequence/screen_a.dart';
import 'popup_sequence/screen_b.dart';

final goRouter = GoRouter(
  initialLocation: '/comment_panel',
  routes: [
    GoRoute(
      path: '/airbridge_qr',
      builder: (context, state) => const AirbridgeQrScreen(),
    ),
    GoRoute(
      path: '/code',
      builder: (context, state) {
        final code = state.uri.queryParameters['code']!;
        final fullUri = state.uri.toString();
        return CodeScreen(code: code, fullUri: fullUri);
      },
    ),
    GoRoute(path: '/a', builder: (context, state) => const ScreenA()),
    GoRoute(path: '/b', builder: (context, state) => const ScreenB()),
    GoRoute(
      path: '/login_background',
      builder: (context, state) => const LoginBackground(),
    ),
    GoRoute(
      path: '/comment_panel',
      builder: (context, state) => const CommentPanelScreen(),
    ),
  ],
);
