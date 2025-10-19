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
  double _panelPos = 0.0; // 0.0 ~ 1.0

  static const double _inputBarHeight = 56; // 인풋바 대략 높이

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final maxH = mq.size.height * 0.4;

    // 패널 진행도에 따른 인풋 상승 높이
    final double liftByPanel = _panelPos * maxH;

    // 키보드 인셋과 패널 중 더 큰 값을 적용하면 충돌 없이 항상 위에 위치
    final double kb = mq.viewInsets.bottom;
    final double bottomLift = liftByPanel > kb ? liftByPanel : kb;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        controller: _panelCtrl,
        minHeight: 0,
        maxHeight: maxH,
        backdropEnabled: false,
        panelSnapping: true,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        onPanelSlide: (pos) => setState(() => _panelPos = pos),
        body: Stack(
          children: [
            /// 메시지 리스트: 인풋이 올라간 만큼 하단 패딩 추가
            Positioned.fill(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.fromLTRB(
                  0,
                  mq.padding.top + 8,
                  0,
                  _inputBarHeight + bottomLift + mq.padding.bottom,
                ),
                itemCount: 40,
                itemBuilder: (_, i) => ListTile(title: Text('Message $i')),
              ),
            ),

            /// 인풋바: 패널/키보드만큼 함께 상승
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomLift,
              child: ChatInputBar(
                onPlus: () {
                  if (_panelCtrl.isPanelOpen) {
                    _panelCtrl.close();
                  } else {
                    _panelCtrl.open();
                  }
                },
                onSend: (text) {
                  // TODO: 메시지 전송
                },
              ),
            ),
          ],
        ),
        panelBuilder: (sc) {
          final kbPanel = MediaQuery.of(context).viewInsets.bottom;
          return Padding(
            padding: EdgeInsets.only(bottom: kbPanel),
            child: MediaGridPanel(
              scrollController: sc,
              onCancel: () => _panelCtrl.close(),
              onSubmit: (picked) {
                // TODO: 선택 미디어 attach
                _panelCtrl.close();
              },
            ),
          );
        },
      ),
    );
  }
}
