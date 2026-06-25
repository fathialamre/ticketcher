import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('TicketcherDecoration equality (transitive divider/watermark)', () {
    test('two decorations with semantically-equal divider ⇒ equal', () {
      final a = TicketcherDecoration(
        divider: TicketDivider.dashed(color: Colors.grey, dashWidth: 8),
      );
      final b = TicketcherDecoration(
        divider: TicketDivider.dashed(color: Colors.grey, dashWidth: 8),
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('two decorations with semantically-equal watermark ⇒ equal', () {
      const a = TicketcherDecoration(
        watermark: TicketWatermark.text(text: 'X'),
      );
      const b = TicketcherDecoration(
        watermark: TicketWatermark.text(text: 'X'),
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('decorations differing only in divider thickness ⇒ unequal', () {
      final a = TicketcherDecoration(
        divider: TicketDivider.solid(thickness: 1),
      );
      final b = TicketcherDecoration(
        divider: TicketDivider.solid(thickness: 2),
      );
      expect(a, isNot(equals(b)));
    });
  });

  group('TicketcherDecoration 2.1.0 fields', () {
    test('differing shadows ⇒ unequal', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      const b = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.blue, blurRadius: 4)],
      );
      expect(a, isNot(equals(b)));
    });

    test('content-equal shadows lists ⇒ equal', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      const b = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red, blurRadius: 4)],
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing topBorderStyle ⇒ unequal', () {
      const a = TicketcherDecoration(
        topBorderStyle: BorderPattern(shape: BorderShape.sharp),
      );
      const b = TicketcherDecoration();
      expect(a, isNot(equals(b)));
    });

    test('differing borderDash ⇒ unequal', () {
      const a = TicketcherDecoration(borderDash: BorderDash(dash: 6, gap: 4));
      const b = TicketcherDecoration(borderDash: BorderDash(dash: 6, gap: 5));
      expect(a, isNot(equals(b)));
    });

    test('differing punchHoles ⇒ unequal; content-equal ⇒ equal', () {
      const a = TicketcherDecoration(punchHoles: [PunchHole(radius: 6)]);
      const b = TicketcherDecoration(punchHoles: [PunchHole(radius: 7)]);
      const c = TicketcherDecoration(punchHoles: [PunchHole(radius: 6)]);
      expect(a, isNot(equals(b)));
      expect(a, equals(c));
      expect(a.hashCode, c.hashCode);
    });

    test('copyWith round-trips new fields', () {
      const a = TicketcherDecoration(
        shadows: [BoxShadow(color: Colors.red)],
        topBorderStyle: BorderPattern(shape: BorderShape.wave),
        borderDash: BorderDash(dash: 6, gap: 4),
        punchHoles: [PunchHole(radius: 6)],
      );
      expect(a.copyWith(), equals(a));
      expect(
        a.copyWith(borderDash: const BorderDash(dash: 1, gap: 1)).borderDash,
        const BorderDash(dash: 1, gap: 1),
      );
    });

    test('null shadows != empty shadows (fallthrough-vs-disable semantic)', () {
      const withNull = TicketcherDecoration();
      const withEmpty = TicketcherDecoration(shadows: []);
      // hashCode collision would be legal, so only equality is asserted.
      expect(withNull, isNot(equals(withEmpty)));
    });

    test('differing stitch ⇒ unequal; content-equal ⇒ equal', () {
      const a = TicketcherDecoration(stitch: TicketStitch(inset: 10));
      const b = TicketcherDecoration(stitch: TicketStitch(inset: 14));
      const c = TicketcherDecoration(stitch: TicketStitch(inset: 10));
      expect(a, isNot(equals(b)));
      expect(a, equals(c));
      expect(a.hashCode, c.hashCode);
    });

    test('copyWith round-trips stitch', () {
      const a = TicketcherDecoration(stitch: TicketStitch(inset: 10));
      expect(a.copyWith(), equals(a));
      expect(
        a.copyWith(stitch: const TicketStitch(inset: 20)).stitch,
        const TicketStitch(inset: 20),
      );
    });
  });
}
