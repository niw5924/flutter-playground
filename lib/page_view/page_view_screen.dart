import 'package:flutter/material.dart';

class PageViewScreen extends StatelessWidget {
  const PageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
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
    );
  }
}
