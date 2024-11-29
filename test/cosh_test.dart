import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

double calculateCosh(double value) {
  // Function to calculate the hyperbolic cosine using Dart's math library
  return (exp(value) + exp(-value)) / 2.0;
}

void main() {
  group('Hyperbolic Cosine Function Tests', () {
    // Basic tests
    test('Cosh of 0 should be 1', () {
      expect(calculateCosh(0), equals(1.0));
    });

    test('Cosh of 1 should be approximately 1.5431', () {
      expect(calculateCosh(1), closeTo(1.5431, 0.0001));
    });

    test('Cosh of 2 should be approximately 3.7622', () {
      expect(calculateCosh(2), closeTo(3.7622, 0.0001));
    });

    test('Cosh of -1 should be approximately 1.5431', () {
      expect(calculateCosh(-1), closeTo(1.5431, 0.0001));
    });

    test('Cosh of -2 should be approximately 3.7622', () {
      expect(calculateCosh(-2), closeTo(3.7622, 0.0001));
    });

    // Small values close to zero
    test('Cosh of 0.01 should be approximately 1.00005', () {
      expect(calculateCosh(0.01), closeTo(1.00005, 0.00001));
    });

    test('Cosh of -0.01 should be approximately 1.00005', () {
      expect(calculateCosh(-0.01), closeTo(1.00005, 0.00001));
    });

    // Larger positive values
    test('Cosh of 10 should be approximately 11013.2329', () {
      expect(calculateCosh(10), closeTo(11013.2329, 0.0001));
    });

    test('Cosh of 20 should be approximately 242582597.7049', () {
      expect(calculateCosh(20), closeTo(242582597.7049, 0.0001));
    });

    test('Cosh of 30 should be approximately 5.3432e12', () {
      expect(calculateCosh(30), closeTo(5.3432e12, 1e8));  // Allowing larger tolerance due to scale
    });

    // Larger negative values (cosh is symmetric so cosh(-x) == cosh(x))
    test('Cosh of -10 should be approximately 11013.2329', () {
      expect(calculateCosh(-10), closeTo(11013.2329, 0.0001));
    });

    test('Cosh of -20 should be approximately 242582597.7049', () {
      expect(calculateCosh(-20), closeTo(242582597.7049, 0.0001));
    });

    test('Cosh of -30 should be approximately 5.3432e12', () {
      expect(calculateCosh(-30), closeTo(5.3432e12, 1e8));
    });

    // Edge cases
    test('Cosh of a very large value should return Infinity', () {
      expect(calculateCosh(710), equals(double.infinity));
    });

    test('Cosh of a very large negative value should return Infinity (symmetric property)', () {
      expect(calculateCosh(-710), equals(double.infinity));
    });

    // Tiny values to ensure stability
    test('Cosh of a very small positive value close to zero', () {
      expect(calculateCosh(1e-10), closeTo(1.0, 1e-10));
    });

    test('Cosh of a very small negative value close to zero', () {
      expect(calculateCosh(-1e-10), closeTo(1.0, 1e-10));
    });
  });
}
