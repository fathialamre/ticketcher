import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('Section equality', () {
    test('identical args ⇒ equal and same hashCode', () {
      const child = Text('hi');
      const a = Section(child: child);
      const b = Section(child: child);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing child ⇒ unequal (regression: stale-paint bug)', () {
      const a = Section(child: Text('A'));
      const b = Section(child: Text('B'));
      expect(a, isNot(equals(b)));
    });

    test('differing color ⇒ unequal', () {
      const child = Text('hi');
      const a = Section(child: child, color: Colors.red);
      const b = Section(child: child, color: Colors.blue);
      expect(a, isNot(equals(b)));
    });

    test('copyWith no-args ⇒ equal', () {
      const a = Section(
        child: Text('hi'),
        color: Colors.red,
        widthFactor: 1.5,
      );
      final b = a.copyWith();
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });
  });
}
