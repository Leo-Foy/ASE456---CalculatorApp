import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/button.dart';
import 'dart:ui';
import 'package:calculator/main.dart';

void main() {
  testWidgets('Tan button calculates tangent correctly', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('0'));
    await tester.tap(find.text('.'));
    await tester.tap(find.text('7'));
    await tester.tap(find.text('8'));
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tan'));
    await tester.pumpAndSettle();

    expect(find.textContaining('0.999'), findsOneWidget);
  });
}