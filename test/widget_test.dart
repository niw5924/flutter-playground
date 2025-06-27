import 'package:flutter/material.dart';
import 'package:flutter_niw/test/widget_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('버튼이 존재하고 탭 가능함', (WidgetTester tester) async {
    // WidgetTest 위젯을 MaterialApp로 감싸서 테스트 환경 구성
    await tester.pumpWidget(const MaterialApp(home: WidgetTest()));

    // 버튼이 화면에 존재하는지 확인
    expect(find.text('버튼'), findsOneWidget);

    // 버튼 탭 시도
    await tester.tap(find.text('버튼'));
    await tester.pump();

    // 콘솔 출력은 테스트에서 확인 불가하지만, 이 시점에 눌림은 발생한 것
  });
}
