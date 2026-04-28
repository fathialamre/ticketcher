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
}
