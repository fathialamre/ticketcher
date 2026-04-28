import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/hticketcher_painter.dart';
import 'package:ticketcher/src/painters/vticketcher_painter.dart';
import 'package:ticketcher/ticketcher.dart';

const _sections = <Section>[
  Section(child: Text('A')),
  Section(child: Text('B')),
];

void main() {
  group('Painter snapshots section sizes (regression)', () {
    // Regression for a real bug: VTicketcher / HTicketcher store the per-
    // section size list in their State and mutate it in place after measuring
    // each section's RenderBox in a post-frame callback. If the painter held
    // that list by reference, the OLD painter and the NEW painter would point
    // at the same (mutated) list, `shouldRepaint(old)` would compare two lists
    // already showing the post-measurement values, return false, and the very
    // first paint (made BEFORE measurement, with the all-zero initial values)
    // would never be replaced — every notch and divider drawn at y=0.

    test(
      'VTicketcherPainter copies sectionHeights so mutation does not leak',
      () {
        final shared = <double>[0.0, 0.0];
        final old = VTicketcherPainter(
          notchRadius: 10,
          sectionHeights: shared,
          decoration: const TicketcherDecoration(),
          sections: _sections,
        );
        // Simulate the State mutating its list in place after measurement.
        shared[0] = 100;
        shared[1] = 50;
        final fresh = VTicketcherPainter(
          notchRadius: 10,
          sectionHeights: shared,
          decoration: const TicketcherDecoration(),
          sections: _sections,
        );
        expect(old.sectionHeights, [0.0, 0.0]);
        expect(fresh.sectionHeights, [100.0, 50.0]);
        expect(fresh.shouldRepaint(old), isTrue);
      },
    );

    test(
      'HTicketcherPainter copies sectionWidths so mutation does not leak',
      () {
        final shared = <double>[0.0, 0.0];
        final old = HTicketcherPainter(
          notchRadius: 10,
          sectionWidths: shared,
          decoration: const TicketcherDecoration(),
          sections: _sections,
        );
        shared[0] = 120;
        shared[1] = 80;
        final fresh = HTicketcherPainter(
          notchRadius: 10,
          sectionWidths: shared,
          decoration: const TicketcherDecoration(),
          sections: _sections,
        );
        expect(old.sectionWidths, [0.0, 0.0]);
        expect(fresh.sectionWidths, [120.0, 80.0]);
        expect(fresh.shouldRepaint(old), isTrue);
      },
    );
  });
}
