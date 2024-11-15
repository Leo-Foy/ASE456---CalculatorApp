import 'package:calculator/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cosine returns correct answer of cosine 1 (in radians)', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    final findCosineButton = find.text('cos');
    final findLeftParentheses = find.text('(');
    final findOne = find.text('1');
    final findRightParentheses = find.text(')');
    final findEquals = find.text('=');

    expect(findCosineButton, findsOneWidget);
    expect(findLeftParentheses, findsOneWidget);
    expect(findOne, findsOneWidget);
    expect(findRightParentheses, findsOneWidget);
    expect(findEquals, findsOneWidget);

    await tester.tap(findCosineButton);
    await tester.pumpAndSettle();
    await tester.tap(findLeftParentheses);
    await tester.pumpAndSettle();
    await tester.tap(findOne);
    await tester.pumpAndSettle();
    await tester.tap(findRightParentheses);
    await tester.pumpAndSettle();
    await tester.tap(findEquals);
    await tester.pumpAndSettle();

    //answer of cos(1) -> since our calculator returns a max of 16 digits
    final findAnswer = find.text('0.54030230586813');

    expect(findAnswer, findsOneWidget);
  });

  testWidgets('Cosine returns correct answer of cosine 85 (in radians)', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    final findCosineButton = find.text('cos');
    final findLeftParentheses = find.text('(');
    final findEight = find.text('8');
    final findFive = find.text('5');
    final findRightParentheses = find.text(')');
    final findEquals = find.text('=');

    expect(findCosineButton, findsOneWidget);
    expect(findLeftParentheses, findsOneWidget);
    expect(findEight, findsOneWidget);
    expect(findFive, findsOneWidget);
    expect(findRightParentheses, findsOneWidget);
    expect(findEquals, findsOneWidget);

    await tester.tap(findCosineButton);
    await tester.pumpAndSettle();
    await tester.tap(findLeftParentheses);
    await tester.pumpAndSettle();
    await tester.tap(findEight);
    await tester.pumpAndSettle();
    await tester.tap(findFive);
    await tester.pumpAndSettle();
    await tester.tap(findRightParentheses);
    await tester.pumpAndSettle();
    await tester.tap(findEquals);
    await tester.pumpAndSettle();

    //answer of cos(85) -> since our calculator returns a max of 16 digits
    final findAnswer = find.text('-0.9843766433940');

    expect(findAnswer, findsOneWidget);
  });
}
