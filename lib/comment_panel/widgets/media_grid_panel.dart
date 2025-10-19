import 'package:flutter/material.dart';

class MediaGridPanel extends StatelessWidget {
  const MediaGridPanel({
    super.key,
    required this.scrollController,
    required this.onCancel,
    required this.onSubmit,
  });

  final ScrollController scrollController;
  final VoidCallback onCancel;
  final void Function(List<int> picked) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: 60,
              itemBuilder:
                  (_, i) => Container(
                    color: Colors.grey.shade300,
                    child: Center(child: Text('$i')),
                  ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(onPressed: onCancel, child: const Text('취소')),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSubmit(const []),
                  child: const Text('첨부'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
