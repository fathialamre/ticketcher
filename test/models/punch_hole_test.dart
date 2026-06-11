import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('PunchHole', () {
    test('defaults: topCenter alignment, zero offset, semicircle shape', () {
      const hole = PunchHole(radius: 6);
      expect(hole.alignment, Alignment.topCenter);
      expect(hole.offset, Offset.zero);
      expect(hole.shape, NotchShape.semicircle);
    });

    test('equal values ⇒ equal and same hashCode', () {
      const a = PunchHole(
        alignment: Alignment.topCenter,
        offset: Offset(0, 12),
        radius: 6,
      );
      const b = PunchHole(
        alignment: Alignment.topCenter,
        offset: Offset(0, 12),
        radius: 6,
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing radius ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 7);
      expect(a, isNot(equals(b)));
    });

    test('differing shape ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 6, shape: NotchShape.diamond);
      expect(a, isNot(equals(b)));
    });

    test('differing alignment ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 6, alignment: Alignment.bottomCenter);
      expect(a, isNot(equals(b)));
    });

    test('differing offset ⇒ unequal', () {
      const a = PunchHole(radius: 6);
      const b = PunchHole(radius: 6, offset: Offset(1, 0));
      expect(a, isNot(equals(b)));
    });

    test('copyWith replaces only given fields', () {
      const a = PunchHole(radius: 6, offset: Offset(2, 3));
      final b = a.copyWith(radius: 9);
      expect(b.radius, 9);
      expect(b.offset, const Offset(2, 3));
      expect(a.copyWith(), equals(a));
    });

    test('non-positive or non-finite radius asserts', () {
      expect(() => PunchHole(radius: 0), throwsAssertionError);
      expect(() => PunchHole(radius: -2), throwsAssertionError);
      expect(() => PunchHole(radius: double.infinity), throwsAssertionError);
      expect(() => PunchHole(radius: double.nan), throwsAssertionError);
    });
  });
}
