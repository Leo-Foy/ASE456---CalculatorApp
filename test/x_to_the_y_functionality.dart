import 'package:calculator/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('x^y returns correct answer of 3^5', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    final findThree = find.text('3');
    final findRoot = find.text('X^y');
    final findFive = find.text('5');
    final findEquals = find.text('=');

    expect(findThree, findsOneWidget);
    expect(findRoot, findsOneWidget);
    expect(findFive, findsOneWidget);
    expect(findEquals, findsOneWidget);

    await tester.tap(findThree);
    await tester.pumpAndSettle();
    await tester.tap(findRoot);
    await tester.pumpAndSettle();
    await tester.tap(findFive);
    await tester.pumpAndSettle();
    await tester.tap(findEquals);
    await tester.pumpAndSettle();

    //answer of 3^5 = 243
    final findAnswer = find.textContaining('243');

    expect(findAnswer, findsOneWidget);
  });

  testWidgets('x^y returns correct answer of 23^6', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    final findTwo = find.text('2');
    final findThree = find.text('3');
    final findRoot = find.text('X^y');
    final findSix = find.text('6');
    final findEquals = find.text('=');

    expect(findTwo, findsOneWidget);
    expect(findThree, findsOneWidget);
    expect(findRoot, findsOneWidget);
    expect(findSix, findsOneWidget);
    expect(findEquals, findsOneWidget);

    await tester.tap(findTwo);
    await tester.pumpAndSettle();
    await tester.tap(findThree);
    await tester.pumpAndSettle();
    await tester.tap(findRoot);
    await tester.pumpAndSettle();
    await tester.tap(findSix);
    await tester.pumpAndSettle();
    await tester.tap(findEquals);
    await tester.pumpAndSettle();

    //answer of 23^6 = 148035889
    final findAnswer = find.textContaining('148035889');

    expect(findAnswer, findsOneWidget);
  });
}
