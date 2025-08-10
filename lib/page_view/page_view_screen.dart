import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final Set<int> _pointers = {};
  bool _lockScroll = false;

  void _handlePointerDown(PointerDownEvent e) {
    _pointers.add(e.pointer);
    if (_pointers.length >= 2 && !_lockScroll) {
      setState(() => _lockScroll = true);
    }
  }

  void _handlePointerUpOrCancel(PointerEvent e) {
    _pointers.remove(e.pointer);
    if (_pointers.length < 2 && _lockScroll) {
      setState(() => _lockScroll = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handlePointerDown,
      onPointerUp: _handlePointerUpOrCancel,
      onPointerCancel: _handlePointerUpOrCancel,
      child: PageView.builder(
        itemCount: 3,
        physics:
            _lockScroll
                ? const NeverScrollableScrollPhysics()
                : const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return _ZoomableImage(path: 'assets/image/pv${index + 1}.png');
        },
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  final String path;

  const _ZoomableImage({required this.path});

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  BoxFit _fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 3.0,
      onInteractionStart: (_) {
        setState(() => _fit = BoxFit.contain);
      },
      child: Image.asset(widget.path, fit: _fit),
    );
  }
}
