import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final Set<int> _pointers = {}; // 현재 화면에 닿아있는 포인터 id들
  bool _lockScroll = false;

  void _handlePointerDown(PointerDownEvent e) {
    _pointers.add(e.pointer);
    if (_pointers.length >= 2 && !_lockScroll) {
      setState(() => _lockScroll = true); // 두 손가락 이상: 스크롤 잠금
    }
  }

  void _handlePointerUpOrCancel(PointerEvent e) {
    _pointers.remove(e.pointer);
    if (_pointers.length < 2 && _lockScroll) {
      setState(() => _lockScroll = false); // 한 손가락 이하: 스크롤 해제
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
          return InteractiveViewer(
            minScale: 1.0,
            maxScale: 3.0,
            child: Image.asset(
              'assets/image/pv${index + 1}.png',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
