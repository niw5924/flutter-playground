import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRtcLoopbackScreen extends StatefulWidget {
  const WebRtcLoopbackScreen({super.key});

  @override
  State<WebRtcLoopbackScreen> createState() => _WebRtcLoopbackScreenState();
}

class _WebRtcLoopbackScreenState extends State<WebRtcLoopbackScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  MediaStream? _localStream;

  RTCPeerConnection? _pc1;
  RTCPeerConnection? _pc2;

  bool _started = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await _startLoopback();
  }

  Future<void> _startLoopback() async {
    final localStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'environment',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
        'frameRate': {'ideal': 30},
      },
      'audio': true,
    });

    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    final pc1 = await createPeerConnection(config);
    final pc2 = await createPeerConnection(config);

    pc1.onIceCandidate = (c) {
      if (c.candidate != null) {
        pc2.addCandidate(c);
      }
    };
    pc2.onIceCandidate = (c) {
      if (c.candidate != null) {
        pc1.addCandidate(c);
      }
    };

    pc2.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams.first;
        });
      }
    };

    for (final track in localStream.getTracks()) {
      await pc1.addTrack(track, localStream);
    }

    _localRenderer.srcObject = localStream;

    final offer = await pc1.createOffer();
    await pc1.setLocalDescription(offer);
    await pc2.setRemoteDescription(offer);

    final answer = await pc2.createAnswer();
    await pc2.setLocalDescription(answer);
    await pc1.setRemoteDescription(answer);

    setState(() {
      _localStream = localStream;
      _pc1 = pc1;
      _pc2 = pc2;
      _started = true;
    });
  }

  Future<void> _stopLoopback() async {
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;

    final s = _localStream;
    _localStream = null;
    s?.getTracks().forEach((t) => t.stop());
    await s?.dispose();

    await _pc1?.close();
    await _pc2?.close();
    _pc1 = null;
    _pc2 = null;

    setState(() {
      _started = false;
    });
  }

  @override
  void dispose() {
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;

    final s = _localStream;
    _localStream = null;
    s?.getTracks().forEach((t) => t.stop());
    s?.dispose();

    _pc1?.close();
    _pc2?.close();
    _pc1 = null;
    _pc2 = null;

    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebRTC Loopback'),
        actions: [
          IconButton(
            onPressed: _started ? _stopLoopback : _startLoopback,
            icon: Icon(_started ? Icons.stop : Icons.play_arrow),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RTCVideoView(
              _localRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          Expanded(
            child: RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
        ],
      ),
    );
  }
}
