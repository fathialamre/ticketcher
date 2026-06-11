import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('BorderDash', () {
    test('equal values ⇒ equal and same hashCode', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 6, gap: 4);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('differing dash ⇒ unequal', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 8, gap: 4);
      expect(a, isNot(equals(b)));
    });

    test('differing gap ⇒ unequal', () {
      const a = BorderDash(dash: 6, gap: 4);
      const b = BorderDash(dash: 6, gap: 5);
      expect(a, isNot(equals(b)));
    });

    test('copyWith replaces only given fields', () {
      const a = BorderDash(dash: 6, gap: 4);
      final b = a.copyWith(gap: 9);
      expect(b.dash, 6);
      expect(b.gap, 9);
      expect(a.copyWith(), equals(a));
    });

    test('non-positive or non-finite dash/gap asserts', () {
      expect(() => BorderDash(dash: 0, gap: 4), throwsAssertionError);
      expect(() => BorderDash(dash: 6, gap: 0), throwsAssertionError);
      expect(() => BorderDash(dash: -1, gap: 4), throwsAssertionError);
      expect(() => BorderDash(dash: double.infinity, gap: 4), throwsAssertionError);
      expect(() => BorderDash(dash: double.nan, gap: 4), throwsAssertionError);
    });
  });
}
