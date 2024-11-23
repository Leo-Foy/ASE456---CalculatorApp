import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

/// Function to calculate the cube of a number.
/// Handles invalid inputs by returning `null`.
double? cube(dynamic x) {
  try {
    if (x is! num) throw ArgumentError("Input must be a number");
    return pow(x, 3).toDouble();
  } catch (e) {
    return null; // Return null for invalid inputs
  }
}

void main() {
  group('Cube Function Tests', () {
    // Basic Cases: Zero and One
    test('Cube of 0 should be 0', () {
      expect(cube(0), equals(0.0));
    });

    test('Cube of 1 should be 1', () {
      expect(cube(1), equals(1.0));
    });

    test('Cube of -1 should be -1', () {
      expect(cube(-1), equals(-1.0));
    });

    // Positive Numbers
    test('Cube of 2 should be 8', () {
      expect(cube(2), equals(8.0));
    });

    test('Cube of 10 should be 1000', () {
      expect(cube(10), equals(1000.0));
    });

    test('Cube of 100 should be 1000000', () {
      expect(cube(100), equals(1e6)); // 100^3 = 1,000,000
    });

    // Negative Numbers
    test('Cube of -2 should be -8', () {
      expect(cube(-2), equals(-8.0));
    });

    test('Cube of -5 should be -125', () {
      expect(cube(-5), equals(-125.0));
    });

    // Decimal Numbers
    test('Cube of 0.5 should be 0.125', () {
      expect(cube(0.5), equals(0.125));
    });

    test('Cube of -0.5 should be -0.125', () {
      expect(cube(-0.5), equals(-0.125));
    });

    test('Cube of 3.5 should be 42.875', () {
      expect(cube(3.5), equals(42.875));
    });

    test('Cube of -3.5 should be -42.875', () {
      expect(cube(-3.5), equals(-42.875));
    });

    // Large Positive and Negative Numbers
    test('Cube of 1000 should be 1e9', () {
      expect(cube(1000), equals(1e9)); // 1000^3 = 1,000,000,000
    });

    test('Cube of -1000 should be -1e9', () {
      expect(cube(-1000), equals(-1e9)); // -1000^3 = -1,000,000,000
    });

    test('Cube of 10000 should be 1e12', () {
      expect(cube(10000), equals(1e12)); // 10,000^3 = 1,000,000,000,000
    });

    test('Cube of -10000 should be -1e12', () {
      expect(cube(-10000), equals(-1e12)); // -10,000^3 = -1,000,000,000,000
    });

    // Very Small Numbers
    test('Cube of a very small positive number (1e-10) should be correct', () {
      expect(cube(1e-10), closeTo(1e-30, 1e-35)); // Floating-point precision
    });

    test('Cube of a very small negative number (-1e-10) should be correct', () {
      expect(cube(-1e-10), closeTo(-1e-30, 1e-35));
    });

    // Extreme Values
    test('Cube of a very large number should return Infinity', () {
      expect(cube(1e308), equals(double.infinity)); // 1e308^3 exceeds floating-point range
    });

    test('Cube of a very large negative number should return -Infinity', () {
      expect(cube(-1e308), equals(double.negativeInfinity)); // -1e308^3 exceeds floating-point range
    });

    // Edge Cases: Invalid and Null Inputs
    test('Cube of null should return null', () {
      expect(cube(null), isNull);
    });

    test('Cube of a non-numeric input should return null', () {
      expect(cube("abc"), isNull); // Non-numeric string
    });

    // Edge Case: NaN
    test('Cube of NaN should return NaN', () {
      expect(cube(double.nan)?.isNaN, isTrue);
    });
  });
}
