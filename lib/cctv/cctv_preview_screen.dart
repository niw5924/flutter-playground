import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CctvPreviewScreen extends StatefulWidget {
  const CctvPreviewScreen({super.key});

  @override
  State<CctvPreviewScreen> createState() => _CctvPreviewScreenState();
}

class _CctvPreviewScreenState extends State<CctvPreviewScreen> {
  final RTCVideoRenderer _renderer = RTCVideoRenderer();
  MediaStream? _stream;

  @override
  void initState() {
    super.initState();
    _initPreview();
  }

  Future<void> _initPreview() async {
    await _renderer.initialize();

    final stream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'environment',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
        'frameRate': {'ideal': 30},
      },
      'audio': true,
    });

    setState(() {
      _stream = stream;
      _renderer.srcObject = stream;
    });
  }

  @override
  void dispose() {
    _renderer.srcObject = null;

    final s = _stream;
    _stream = null;
    s?.getTracks().forEach((t) => t.stop());
    s?.dispose();

    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ready = _stream != null;

    return Scaffold(
      appBar: AppBar(title: const Text('CCTV 프리뷰')),
      body: Center(
        child:
            ready
                ? RTCVideoView(
                  _renderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
