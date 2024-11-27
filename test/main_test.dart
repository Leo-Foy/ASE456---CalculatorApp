import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart';

void main() {
  group('Calculations', () {
    test('add', () {
      expect(Calculations.add(105, 105), 210);
    });

    test('subtract', () {
      expect(Calculations.subtract(105, 90), 15);
    });

    test('divide', () {
      expect(Calculations.divide(100, 25), 4);
    });

    test('multiply', () {
      expect(Calculations.multiply(100, 25), 2500);
    });
  });

}