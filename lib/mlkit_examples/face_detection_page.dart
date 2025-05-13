import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  String _result = '처리 중...';

  @override
  void initState() {
    super.initState();
    _detectFacesFromAsset(); // 앱 시작 시 얼굴 인식 수행
  }

  // asset 이미지에서 얼굴 인식
  Future<void> _detectFacesFromAsset() async {
    final file = await _loadAssetAsFile('assets/image/image3.jpg');
    final inputImage = InputImage.fromFile(file);

    final options = FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    );
    final faceDetector = FaceDetector(options: options);
    final faces = await faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      setState(() {
        _result = '얼굴이 감지되지 않았습니다.';
      });
      return;
    }

    final buffer = StringBuffer();
    for (int i = 0; i < faces.length; i++) {
      final face = faces[i];
      buffer.writeln('👤 얼굴 ${i + 1}:');
      buffer.writeln(' - BoundingBox: ${face.boundingBox}');
      buffer.writeln(
        ' - 웃을 확률: ${face.smilingProbability?.toStringAsFixed(2)}',
      );
      buffer.writeln(
        ' - 왼쪽 눈 열림: ${face.leftEyeOpenProbability?.toStringAsFixed(2)}',
      );
      buffer.writeln(
        ' - 오른쪽 눈 열림: ${face.rightEyeOpenProbability?.toStringAsFixed(2)}\n',
      );
    }

    setState(() {
      _result = buffer.toString();
    });

    await faceDetector.close(); // 리소스 해제
  }

  // asset 이미지를 임시 파일로 저장
  Future<File> _loadAssetAsFile(String path) async {
    final byteData = await rootBundle.load(path);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/image3.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ML Kit 얼굴 인식')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(_result)),
      ),
    );
  }
}
