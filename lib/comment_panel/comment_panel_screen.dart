import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/media_grid_panel.dart';

class CommentPanelScreen extends StatefulWidget {
  const CommentPanelScreen({super.key});

  @override
  State<CommentPanelScreen> createState() => _CommentPanelScreenState();
}

class _CommentPanelScreenState extends State<CommentPanelScreen> {
  final PanelController _panelCtrl = PanelController();
  double _panelPos = 0.0; // 패널 진행도(0~1)

  static const double _overlayThreshold = 0.4; // 인풋이 함께 올라가는 구간 비율
  static const double _inputBarHeight = 56; // 인풋바 높이

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double maxH = mq.size.height * 0.8; // 패널 최대 높이
    final double panelPx = _panelPos * maxH; // 패널 현재 픽셀 높이
    final double thresholdPx = _overlayThreshold * maxH; // 0.4 지점 픽셀

    final double kb = mq.viewInsets.bottom; // 키보드 인셋
    final double liftCapped =
        panelPx.clamp(0.0, thresholdPx).toDouble(); // 0.4까지만 상승
    final double bottomLift = (kb > liftCapped) ? kb : liftCapped; // 인풋 상승치

    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        controller: _panelCtrl,
        minHeight: 0,
        maxHeight: maxH,
        // 딤/배경탭 닫힘 없음
        backdropEnabled: false,
        panelSnapping: true,
        // 중간 스냅(0.4)
        snapPoint: _overlayThreshold,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        // 진행도 갱신
        onPanelSlide: (pos) => setState(() => _panelPos = pos),
        body: Stack(
          children: [
            Positioned.fill(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.fromLTRB(
                  0,
                  mq.padding.top + 8,
                  0,
                  _inputBarHeight + bottomLift + mq.padding.bottom,
                ), // 인풋 공간 확보
                itemCount: 40,
                itemBuilder: (_, i) => ListTile(title: Text('Message $i')),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomLift, // 0.4까지만 함께 상승
              child: ChatInputBar(
                onPlus: () {
                  if (_panelCtrl.isPanelOpen) {
                    _panelCtrl.close(); // 닫기(0.0)
                  } else {
                    _panelCtrl.animatePanelToPosition(
                      _overlayThreshold,
                    ); // 0.4로 열기
                  }
                },
                onSend: (text) {
                  // 메시지 전송
                },
              ),
            ),
          ],
        ),
        panelBuilder: (sc) {
          final double kbPanel =
              MediaQuery.of(context).viewInsets.bottom; // 패널 키보드 인셋
          return Padding(
            padding: EdgeInsets.only(bottom: kbPanel),
            child: MediaGridPanel(
              scrollController: sc, // 드래그/스크롤 연동
              onCancel: () => _panelCtrl.close(), // 취소 시 닫기
              onSubmit: (picked) {
                // 선택 미디어 attach
                _panelCtrl.close(); // 완료 시 닫기
              },
            ),
          );
        },
      ),
    );
  }
}
