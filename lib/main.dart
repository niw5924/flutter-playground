import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter_niw/airbridge_qr/airbridge_qr_screen.dart';
import 'package:flutter_niw/airbridge_qr/code_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();
  late final AppLinks _appLinks;
  String? _lastHandledUri;

  @override
  void initState() {
    super.initState();
    _initAppLinks();
  }

  Future<void> _initAppLinks() async {
    _appLinks = AppLinks();

    // 앱이 꺼져있다가 링크로 실행된 경우
    final initial = await _appLinks.getInitialLink();
    if (initial != null) _handleUri(initial);

    // 앱이 실행 중일 때 새 링크 수신
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    final uriStr = uri.toString();
    if (_lastHandledUri == uriStr) return; // 중복 방지
    _lastHandledUri = uriStr;

    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) return;

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
