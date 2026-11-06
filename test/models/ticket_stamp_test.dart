import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('TicketStamp', () {
    test('value equality and hashCode', () {
      const a = TicketStamp(text: 'USED', subtitle: '14 DEC');
      const b = TicketStamp(text: 'USED', subtitle: '14 DEC');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == const TicketStamp(text: 'VOID'), isFalse);
      expect(a == a.copyWith(shape: StampShape.seal), isFalse);
    });

    test('copyWith overrides only the given fields', () {
      const base = TicketStamp(text: 'USED');
      final changed = base.copyWith(
        shape: StampShape.ribbon,
        borderStyle: StampBorderStyle.dashed,
      );
      expect(changed.text, 'USED');
      expect(changed.shape, StampShape.ribbon);
      expect(changed.borderStyle, StampBorderStyle.dashed);
      expect(changed.color, base.color);
    });

    test('presets pick distinct shapes and colors', () {
      expect(const TicketStamp.used().text, 'USED');
      expect(const TicketStamp.voided().shape, StampShape.rectangle);
      expect(const TicketStamp.paid().shape, StampShape.circle);
      expect(const TicketStamp.vip().shape, StampShape.seal);
      expect(
        const TicketStamp.used(text: 'مُستخدَمة').text,
        'مُستخدَمة',
      );
      expect(
        const TicketStamp.paid().color == const TicketStamp.used().color,
        isFalse,
      );
    });

    test('asserts on invalid opacity and border width', () {
      expect(
        () => TicketStamp(text: 'X', opacity: 1.5),
        throwsAssertionError,
      );
      expect(
        () => TicketStamp(text: 'X', borderWidth: 0),
        throwsAssertionError,
      );
    });
  });

  group('TicketcherDecoration stamp/status', () {
    test('defaults to no stamp and active status', () {
      const d = TicketcherDecoration();
      expect(d.stamp, isNull);
      expect(d.status, TicketStatus.active);
    });

    test('equality includes stamp and status', () {
      const a = TicketcherDecoration(stamp: TicketStamp.used());
      const b = TicketcherDecoration(stamp: TicketStamp.used());
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == const TicketcherDecoration(stamp: TicketStamp.paid()),
          isFalse);
      expect(
        a == a.copyWith(status: TicketStatus.expired),
        isFalse,
      );
    });

    test('copyWith carries stamp and status', () {
      final d = const TicketcherDecoration().copyWith(
        stamp: const TicketStamp.vip(),
        status: TicketStatus.expired,
      );
      expect(d.stamp, const TicketStamp.vip());
      expect(d.status, TicketStatus.expired);
      expect(d.copyWith(backgroundColor: Colors.red).stamp,
          const TicketStamp.vip());
    });
  });

  test('presets accept a color override', () {
    const blue = Color(0xFF2F5BFF);
    expect(const TicketStamp.used(color: blue).color, blue);
    expect(const TicketStamp.voided(color: blue).color, blue);
    expect(const TicketStamp.paid(color: blue).color, blue);
    expect(const TicketStamp.vip(color: blue).color, blue);
    // Shape and border come from the preset, not the default.
    expect(const TicketStamp.paid(color: blue).shape, StampShape.circle);
  });
}
