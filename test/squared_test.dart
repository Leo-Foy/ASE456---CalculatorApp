import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

double calculateSquare(double value) {
  // Function to calculate square
  return pow(value, 2).toDouble();
}

void main() {
  group('Square Function Tests', () {
    // Basic tests
    test('Square of 0 should be 0', () {
      expect(calculateSquare(0), equals(0.0));
    });

    test('Square of 1 should be 1', () {
      expect(calculateSquare(1), equals(1.0));
    });

    test('Square of 2 should be 4', () {
      expect(calculateSquare(2), equals(4.0));
    });

    test('Square of -2 should be 4', () {
      expect(calculateSquare(-2), equals(4.0));
    });

    test('Square of 10 should be 100', () {
      expect(calculateSquare(10), equals(100.0));
    });

    // Larger numbers
    test('Square of 100 should be 10000', () {
      expect(calculateSquare(100), equals(10000.0));
    });

    test('Square of -100 should be 10000', () {
      expect(calculateSquare(-100), equals(10000.0));
    });

    // Fractional values
    test('Square of 0.5 should be 0.25', () {
      expect(calculateSquare(0.5), closeTo(0.25, 0.0001));
    });

    test('Square of -0.5 should be 0.25', () {
      expect(calculateSquare(-0.5), closeTo(0.25, 0.0001));
    });

    // Edge cases
    test('Square of a very large number should be correctly computed', () {
      expect(calculateSquare(1e6), equals(1e12));
    });

    test('Square of a very small number close to zero', () {
      expect(calculateSquare(1e-6), closeTo(1e-12, 1e-16));
    });
  });
}
