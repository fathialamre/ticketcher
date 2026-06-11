import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/src/painters/ticket_path_builder.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('punch holes in TicketPathBuilder', () {
    const decoration = TicketcherDecoration(
      punchHoles: [
        PunchHole(
          alignment: Alignment.topCenter,
          offset: Offset(0, 50),
          radius: 10,
        ),
      ],
    );

    test('vertical clip path: hole center is outside, rim points correct', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: decoration,
        sectionHeights: const [150, 150],
      );
      // Hole center: topCenter of 200x300 = (100, 0), + (0, 50) = (100, 50).
      expect(path.contains(const Offset(100, 50)), isFalse);
      // (100, 56): center.y + 6 — still inside the r=10 hole.
      expect(path.contains(const Offset(100, 56)), isFalse);
      expect(path.contains(const Offset(100, 62)), isTrue); // just past rim
      expect(path.contains(const Offset(100, 100)), isTrue); // ticket body
    });

    test('horizontal clip path: hole cut out too', () {
      final path = TicketPathBuilder.buildHorizontalTicketPath(
        size: const Size(300, 150),
        notchRadius: 10,
        decoration: const TicketcherDecoration(
          punchHoles: [
            PunchHole(
              alignment: Alignment.centerLeft,
              offset: Offset(30, 0),
              radius: 8,
            ),
          ],
        ),
        sectionWidths: const [150, 150],
      );
      // Hole center: centerLeft of 300x150 = (0, 75), + (30, 0) = (30, 75).
      expect(path.contains(const Offset(30, 75)), isFalse);
      expect(path.contains(const Offset(50, 75)), isTrue);
    });

    test('square hole shape cuts a square', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: const TicketcherDecoration(
          punchHoles: [
            PunchHole(
              alignment: Alignment.center,
              radius: 10,
              shape: NotchShape.square,
            ),
          ],
        ),
        sectionHeights: const [150, 150],
      );
      // Center of ticket = (100, 150). Square corner (108, 142) is inside the
      // square hole but OUTSIDE a circle of r=10 — distinguishes the shapes.
      expect(path.contains(const Offset(100, 150)), isFalse);
      expect(path.contains(const Offset(108, 142)), isFalse);
      expect(path.contains(const Offset(100, 165)), isTrue);
    });

    test('triangle hole shape cuts a downward-pointing triangle', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: const TicketcherDecoration(
          punchHoles: [
            PunchHole(
              alignment: Alignment.center,
              radius: 10,
              shape: NotchShape.triangle,
            ),
          ],
        ),
        sectionHeights: const [150, 150],
      );
      // Center of ticket = (100, 150). Apex (100, 140), base (90,160)-(110,160).
      expect(path.contains(const Offset(100, 150)), isFalse); // inside triangle
      expect(path.contains(const Offset(100, 155)), isFalse); // lower interior
      // (92, 142): inside the bounding box but outside the narrow apex region —
      // distinguishes a triangle from a square/circle of the same radius.
      expect(path.contains(const Offset(92, 142)), isTrue);
      expect(path.contains(const Offset(100, 138)), isTrue); // above apex
    });

    test('no holes => path unchanged behavior (contains center)', () {
      final path = TicketPathBuilder.buildVerticalTicketPath(
        size: const Size(200, 300),
        notchRadius: 10,
        decoration: const TicketcherDecoration(),
        sectionHeights: const [150, 150],
      );
      expect(path.contains(const Offset(100, 150)), isTrue);
    });
  });
}
