import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final VideoPlayerController _controller;
  late final VoidCallback _listener;
  bool _isReady = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/free_video.mp4');
    _listener = () {
      if (!mounted) return;
      final v = _controller.value;
      if (v.hasError && _errorText != v.errorDescription) {
        setState(() => _errorText = v.errorDescription ?? '재생 오류');
      }
    };
    _controller.addListener(_listener);
    _init();
  }

  Future<void> _init() async {
    try {
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.setVolume(1.0);
      await _controller.play();
      if (mounted) setState(() => _isReady = true);
    } catch (e) {
      if (mounted) setState(() => _errorText = '재생 실패: $e');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video')),
      body: Center(
        child:
            _errorText != null
                ? Text(_errorText!, textAlign: TextAlign.center)
                : (!_isReady
                    ? const CircularProgressIndicator()
                    : Container(
                      width: 400,
                      height: 500,
                      color: Colors.red,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    )),
      ),
    );
  }
}
