import 'package:go_router/go_router.dart';

import 'popup_sequence/popup_sequence_screen.dart';
import 'popup_sequence/screen_a.dart';
import 'popup_sequence/screen_b.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PopupSequenceScreen(),
    ),
    GoRoute(path: '/a', builder: (context, state) => const ScreenA()),
    GoRoute(path: '/b', builder: (context, state) => const ScreenB()),
  ],
);
