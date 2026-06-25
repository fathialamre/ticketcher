import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/painters/ticket_path_builder.dart';

void main() {
  group('buildVerticalStitchPath', () {
    final path = TicketPathBuilder.buildVerticalStitchPath(
      size: const Size(200, 400),
      notchRadius: 10,
      decoration: const TicketcherDecoration(),
      sectionHeights: const [200, 200],
      inset: 12,
    );

    test('non-empty path', () {
      final len = path
          .computeMetrics()
          .fold<double>(0, (s, m) => s + m.length);
      expect(len, greaterThan(0));
    });

    test('stays within the deflated rect', () {
      final b = path.getBounds();
      expect(b.left, greaterThanOrEqualTo(12 - 0.5));
      expect(b.top, greaterThanOrEqualTo(12 - 0.5));
      expect(b.right, lessThanOrEqualTo(200 - 12 + 0.5));
      expect(b.bottom, lessThanOrEqualTo(400 - 12 + 0.5));
    });

    test('encloses the interior', () {
      expect(path.contains(const Offset(100, 200)), isTrue);
      expect(path.contains(const Offset(2, 2)), isFalse);
    });

    test('notch indents the right edge at the section boundary', () {
      // Away from the notch the right boundary is the straight inset edge (x=188).
      expect(path.contains(const Offset(185, 100)), isTrue);
      // At the notch centre (y=200) the boundary dips inward to x=178.
      expect(path.contains(const Offset(185, 200)), isFalse);
    });
  });

  group('buildHorizontalStitchPath', () {
    final path = TicketPathBuilder.buildHorizontalStitchPath(
      size: const Size(400, 200),
      notchRadius: 10,
      decoration: const TicketcherDecoration(),
      sectionWidths: const [200, 200],
      inset: 12,
    );

    test('non-empty path within the deflated rect', () {
      final len = path
          .computeMetrics()
          .fold<double>(0, (s, m) => s + m.length);
      expect(len, greaterThan(0));
      final b = path.getBounds();
      expect(b.left, greaterThanOrEqualTo(12 - 0.5));
      expect(b.right, lessThanOrEqualTo(400 - 12 + 0.5));
      expect(b.top, greaterThanOrEqualTo(12 - 0.5));
      expect(b.bottom, lessThanOrEqualTo(200 - 12 + 0.5));
    });

    test('notch indents the top edge at the section boundary', () {
      expect(path.contains(const Offset(100, 18)), isTrue);
      expect(path.contains(const Offset(200, 18)), isFalse);
    });

    test('notch indents the bottom edge at the section boundary', () {
      expect(path.contains(const Offset(100, 182)), isTrue);
      expect(path.contains(const Offset(200, 182)), isFalse);
    });
  });
}
