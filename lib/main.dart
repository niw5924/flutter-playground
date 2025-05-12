import 'package:flutter/material.dart';
import 'mlkit_examples/text_recognition_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TextRecognitionPage());
  }
}
