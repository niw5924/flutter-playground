import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AirbridgeQrScreen extends StatelessWidget {
  const AirbridgeQrScreen({super.key});

  /// 에어브릿지 단축 링크
  static const String _link = 'https://abr.ge/223xbi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImageView(data: _link, version: QrVersions.auto, size: 240),
      ),
    );
  }
}
