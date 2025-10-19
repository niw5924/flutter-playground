import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key, required this.onPlus, required this.onSend});

  final VoidCallback onPlus;
  final void Function(String text) onSend;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.add), onPressed: widget.onPlus),
          Expanded(
            child: TextField(
              controller: _c,
              decoration: const InputDecoration(
                hintText: '댓글을 입력하세요',
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              minLines: 1,
              maxLines: 4,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => widget.onSend(_c.text),
          ),
        ],
      ),
    );
  }
}
