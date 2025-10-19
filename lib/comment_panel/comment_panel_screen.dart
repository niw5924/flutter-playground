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

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final maxH = mq.size.height * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        controller: _panelCtrl,
        minHeight: 0,
        maxHeight: maxH,
        backdropEnabled: true,
        panelSnapping: true,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: mq.padding.top + 8),
                itemCount: 40,
                itemBuilder: (_, i) => ListTile(title: Text('Message $i')),
              ),
            ),
            ChatInputBar(
              onPlus: () {
                if (_panelCtrl.isPanelOpen) {
                  _panelCtrl.close();
                } else {
                  _panelCtrl.open();
                }
              },
              onSend: (text) {
                // TODO: 메시지 전송 로직
              },
            ),
          ],
        ),
        panelBuilder: (sc) {
          final kb = MediaQuery.of(context).viewInsets.bottom;
          return Padding(
            padding: EdgeInsets.only(bottom: kb),
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
