import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('TicketDivider equality', () {
    test('two solid with same args ⇒ equal', () {
      final a = TicketDivider.solid(color: Colors.grey, thickness: 1);
      final b = TicketDivider.solid(color: Colors.grey, thickness: 1);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('different style ⇒ unequal', () {
      final a = TicketDivider.solid(color: Colors.grey);
      final b = TicketDivider.dashed(color: Colors.grey);
      expect(a, isNot(equals(b)));
    });

    test('dashed differing in dashWidth ⇒ unequal', () {
      final a = TicketDivider.dashed(dashWidth: 5);
      final b = TicketDivider.dashed(dashWidth: 10);
      expect(a, isNot(equals(b)));
    });

    test('circles differing in spacing ⇒ unequal', () {
      final a = TicketDivider.circles(circleSpacing: 5);
      final b = TicketDivider.circles(circleSpacing: 10);
      expect(a, isNot(equals(b)));
    });

    test('wave differing in waveHeight ⇒ unequal', () {
      final a = TicketDivider.wave(waveHeight: 4);
      final b = TicketDivider.wave(waveHeight: 8);
      expect(a, isNot(equals(b)));
    });

    test('smoothWave equal when args match', () {
      final a = TicketDivider.smoothWave(waveWidth: 12, waveHeight: 6);
      final b = TicketDivider.smoothWave(waveWidth: 12, waveHeight: 6);
      expect(a, equals(b));
    });

    test('dotted differing in dotSize ⇒ unequal', () {
      final a = TicketDivider.dotted(dotSize: 2);
      final b = TicketDivider.dotted(dotSize: 4);
      expect(a, isNot(equals(b)));
    });

    test('doubleLine differing in lineSpacing ⇒ unequal', () {
      final a = TicketDivider.doubleLine(lineSpacing: 4);
      final b = TicketDivider.doubleLine(lineSpacing: 8);
      expect(a, isNot(equals(b)));
    });

    test('tearLine differing in scissorsSize ⇒ unequal', () {
      final a = TicketDivider.tearLine(scissorsSize: 12);
      final b = TicketDivider.tearLine(scissorsSize: 20);
      expect(a, isNot(equals(b)));
    });

    test('gradientSolid equal with same gradient', () {
      const g = LinearGradient(colors: [Colors.red, Colors.blue]);
      final a = TicketDivider.gradientSolid(gradient: g);
      final b = TicketDivider.gradientSolid(gradient: g);
      expect(a, equals(b));
    });
  });
}
