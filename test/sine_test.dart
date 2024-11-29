import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

double calculateSine(double degrees) {
  // Convert degrees to radians and calculate sine
  double radians = degrees * (pi / 180);
  return sin(radians);
}

void main() {
  group('Sine Function Tests', () {
    // Basic tests
    test('Sine of 0° should be 0', () {
      expect(calculateSine(0), equals(0.0));
    });

    test('Sine of 30° should be approximately 0.5', () {
      expect(calculateSine(30), closeTo(0.5, 0.0001));
    });

    test('Sine of 90° should be approximately 1', () {
      expect(calculateSine(90), closeTo(1.0, 0.0001));
    });

    test('Sine of 180° should be 0', () {
      expect(calculateSine(180), closeTo(0.0, 0.0001));
    });

    test('Sine of 270° should be approximately -1', () {
      expect(calculateSine(270), closeTo(-1.0, 0.0001));
    });

    test('Sine of -30° should be approximately -0.5', () {
      expect(calculateSine(-30), closeTo(-0.5, 0.0001));
    });

    // Edge cases
    test('Sine of 360° should be 0 (repeat cycle)', () {
      expect(calculateSine(360), closeTo(0.0, 0.0001));
    });

    test('Sine of -360° should be 0 (repeat cycle)', () {
      expect(calculateSine(-360), closeTo(0.0, 0.0001));
    });

    test('Sine of 45° should be approximately 0.7071', () {
      expect(calculateSine(45), closeTo(0.7071, 0.0001));
    });

    test('Sine of -45° should be approximately -0.7071', () {
      expect(calculateSine(-45), closeTo(-0.7071, 0.0001));
    });
  });
}
