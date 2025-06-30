import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DragCanvasPage extends StatefulWidget {
  const DragCanvasPage({super.key});

  @override
  State<DragCanvasPage> createState() => _DragCanvasPageState();
}

class _DragCanvasPageState extends State<DragCanvasPage> {
  final List<_ImageItem> _images = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images.add(
          _ImageItem(file: File(picked.path), offset: const Offset(100, 100)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('도화지 위 사진 배치')),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children:
            _images
                .map(
                  (item) => _ResizableDraggableImage(
                    image: item.file,
                    initialOffset: item.offset,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _ImageItem {
  File file;
  Offset offset;

  _ImageItem({required this.file, required this.offset});
}

class _ResizableDraggableImage extends StatefulWidget {
  final File image;
  final Offset initialOffset;

  const _ResizableDraggableImage({
    required this.image,
    required this.initialOffset,
  });

  @override
  State<_ResizableDraggableImage> createState() =>
      _ResizableDraggableImageState();
}

class _ResizableDraggableImageState extends State<_ResizableDraggableImage> {
  late Offset _offset;
  Offset _startFocalPoint = Offset.zero;
  Offset _baseOffset = Offset.zero;

  double _imageWidth = 150;
  double _baseWidth = 150;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onScaleStart: (details) {
          _startFocalPoint = details.focalPoint;
          _baseOffset = _offset;
          _baseWidth = _imageWidth;
        },
        onScaleUpdate: (details) {
          setState(() {
            final newWidth = (_baseWidth * details.scale).clamp(50.0, 500.0);
            final delta = details.focalPoint - _startFocalPoint;

            // 중심 기준으로 위치 보정
            final correction = Offset(
              (newWidth - _baseWidth) / 2,
              (newWidth - _baseWidth) / 2,
            );

            _offset = _baseOffset + delta - correction;
            _imageWidth = newWidth;
          });
        },
        child: Image.file(widget.image, width: _imageWidth),
      ),
    );
  }
}
