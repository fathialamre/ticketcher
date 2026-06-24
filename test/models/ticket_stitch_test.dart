import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('TicketStitch', () {
    test('equal values ⇒ equal and same hashCode', () {
      const a = TicketStitch(color: Colors.white, inset: 10, length: 6, spacing: 6);
      const b = TicketStitch(color: Colors.white, inset: 10, length: 6, spacing: 6);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing fields ⇒ unequal', () {
      const base = TicketStitch();
      expect(base, isNot(equals(const TicketStitch(color: Colors.black))));
      expect(base, isNot(equals(const TicketStitch(inset: 14))));
      expect(base, isNot(equals(const TicketStitch(length: 8))));
      expect(base, isNot(equals(const TicketStitch(spacing: 8))));
      expect(base, isNot(equals(const TicketStitch(thickness: 3))));
      expect(base, isNot(equals(const TicketStitch(cap: StrokeCap.butt))));
    });

    test('copyWith replaces only given fields', () {
      const a = TicketStitch(inset: 10, length: 6);
      final b = a.copyWith(length: 9);
      expect(b.inset, 10);
      expect(b.length, 9);
      expect(a.copyWith(), equals(a));
    });

    test('defaults are white / round-cap / 10-6-6-2', () {
      const a = TicketStitch();
      expect(a.color, Colors.white);
      expect(a.inset, 10);
      expect(a.length, 6);
      expect(a.spacing, 6);
      expect(a.thickness, 2);
      expect(a.cap, StrokeCap.round);
    });

    test('non-positive or non-finite numeric fields assert', () {
      expect(() => TicketStitch(inset: 0), throwsAssertionError);
      expect(() => TicketStitch(length: 0), throwsAssertionError);
      expect(() => TicketStitch(spacing: -1), throwsAssertionError);
      expect(() => TicketStitch(thickness: 0), throwsAssertionError);
      expect(() => TicketStitch(inset: double.infinity), throwsAssertionError);
      expect(() => TicketStitch(length: double.nan), throwsAssertionError);
    });
  });
}
