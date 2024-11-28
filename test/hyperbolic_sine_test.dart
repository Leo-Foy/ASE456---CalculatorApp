import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart';

void main() {
  // Group tests for clarity
  group('sinh function tests', () {
    test('sinh(0) should return 0', () {
      // Arrange
      final homePageState = _HomePageState();

      // Act
      final result = homePageState.sinh(0);

      // Assert
      expect(result, 0.0);
    });

    test('sinh(1) should return approximately 1.175201', () {
      // Arrange
      final homePageState = _HomePageState();

      // Act
      final result = homePageState.sinh(1);

      // Assert
      expect(result, closeTo(1.175201, 0.000001));
    });

    test('sinh(-1) should return approximately -1.175201', () {
      // Arrange
      final homePageState = _HomePageState();

      // Act
      final result = homePageState.sinh(-1);

      // Assert
      expect(result, closeTo(-1.175201, 0.000001));
    });

    test('sinh(10) should return approximately 11013.23287', () {
      // Arrange
      final homePageState = _HomePageState();

      // Act
      final result = homePageState.sinh(10);

      // Assert
      expect(result, closeTo(11013.23287, 0.00001));
    });
  });
}
