import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/path_dasher.dart';
import 'package:ticketcher/ticketcher.dart';

double _totalLength(Path path) {
  double sum = 0;
  for (final metric in path.computeMetrics()) {
    sum += metric.length;
  }
  return sum;
}

void main() {
  group('dashPath', () {
    test('straight line: dashed length = dashes only', () {
      final line = Path()
        ..moveTo(0, 0)
        ..lineTo(100, 0);
      final dashed = dashPath(line, const BorderDash(dash: 6, gap: 4));
      // Segments start at 0,10,20,...,90 → 10 dashes × 6px = 60px.
      expect(_totalLength(dashed), closeTo(60, 0.1));
    });

    test('trailing partial dash is clamped to the path end', () {
      final line = Path()
        ..moveTo(0, 0)
        ..lineTo(13, 0);
      final dashed = dashPath(line, const BorderDash(dash: 6, gap: 4));
      // Dash 1: [0,6]; dash 2 starts at 10, clamped to [10,13] → 6+3 = 9.
      expect(_totalLength(dashed), closeTo(9, 0.1));
    });

    test('closed contour is dashed across its full perimeter', () {
      final square = Path()..addRect(const Rect.fromLTWH(0, 0, 50, 50));
      final dashed = dashPath(square, const BorderDash(dash: 5, gap: 5));
      // Perimeter 200, duty cycle 1/2 → 100px of dashes.
      expect(_totalLength(dashed), closeTo(100, 0.5));
    });

    test('empty path yields empty result', () {
      final dashed = dashPath(Path(), const BorderDash(dash: 5, gap: 5));
      expect(dashed.computeMetrics().isEmpty, isTrue);
    });
  });
}
