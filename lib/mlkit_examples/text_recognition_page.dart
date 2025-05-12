import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

class TextRecognitionPage extends StatefulWidget {
  const TextRecognitionPage({super.key});

  @override
  State<TextRecognitionPage> createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  String _recognizedText = '처리 중...';

  @override
  void initState() {
    super.initState();
    _processAssetImage();
  }

  // assets 이미지(jpg)를 ML Kit에서 사용할 수 있게 변환
  Future<void> _processAssetImage() async {
    final file = await _loadAssetAsFile('assets/image/image1.jpg');
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
    final result = await textRecognizer.processImage(inputImage);
    setState(() {
      _recognizedText = result.text;
    });
  }

  // asset 이미지(jpg)를 임시 파일로 저장
  Future<File> _loadAssetAsFile(String path) async {
    final byteData = await rootBundle.load(path);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/image1.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ML Kit 텍스트 인식')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(_recognizedText)),
      ),
    );
  }
}
