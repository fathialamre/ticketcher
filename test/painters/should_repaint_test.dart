import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/painters/vticketcher_painter.dart';
import 'package:ticketcher/src/painters/hticketcher_painter.dart';

const _sections = <Section>[
  Section(child: Text('A')),
  Section(child: Text('B')),
];

VTicketcherPainter _vp({
  List<double>? heights,
  TicketcherDecoration? decoration,
  List<Section>? sections,
}) {
  return VTicketcherPainter(
    notchRadius: 10,
    sectionHeights: heights ?? <double>[100, 100],
    decoration: decoration ?? const TicketcherDecoration(),
    sections: sections ?? _sections,
  );
}

HTicketcherPainter _hp({
  List<double>? widths,
  TicketcherDecoration? decoration,
  List<Section>? sections,
}) {
  return HTicketcherPainter(
    notchRadius: 10,
    sectionWidths: widths ?? <double>[100, 100],
    decoration: decoration ?? const TicketcherDecoration(),
    sections: sections ?? _sections,
  );
}

void main() {
  group('VTicketcherPainter.shouldRepaint', () {
    test('content-equal but distinct list instances ⇒ false', () {
      final a = _vp(heights: <double>[100.0, 200.0]);
      final b = _vp(heights: <double>[100.0, 200.0]);
      expect(b.shouldRepaint(a), isFalse);
    });

    test('sub-pixel difference within epsilon ⇒ false', () {
      final a = _vp(heights: <double>[100.0, 200.0]);
      final b = _vp(heights: <double>[100.3, 200.1]);
      expect(b.shouldRepaint(a), isFalse);
    });

    test('difference >= 0.5 px ⇒ true', () {
      final a = _vp(heights: <double>[100.0, 200.0]);
      final b = _vp(heights: <double>[100.6, 200.0]);
      expect(b.shouldRepaint(a), isTrue);
    });

    test('different notchRadius ⇒ true', () {
      final a = _vp();
      final b = VTicketcherPainter(
        notchRadius: 11,
        sectionHeights: const <double>[100, 100],
        decoration: const TicketcherDecoration(),
        sections: _sections,
      );
      expect(b.shouldRepaint(a), isTrue);
    });

    test('different decoration backgroundColor ⇒ true', () {
      final a = _vp();
      final b = _vp(
        decoration: const TicketcherDecoration(backgroundColor: Colors.red),
      );
      expect(b.shouldRepaint(a), isTrue);
    });

    test('different section child ⇒ true (regression: stale-paint bug)', () {
      final a = _vp();
      final b = _vp(
        sections: const [
          Section(child: Text('X')),
          Section(child: Text('B')),
        ],
      );
      expect(b.shouldRepaint(a), isTrue);
    });

    test('semantically-equal divider in decoration ⇒ false', () {
      final a = _vp(
        decoration: TicketcherDecoration(
          divider: TicketDivider.dashed(color: Colors.grey),
        ),
      );
      final b = _vp(
        decoration: TicketcherDecoration(
          divider: TicketDivider.dashed(color: Colors.grey),
        ),
      );
      expect(b.shouldRepaint(a), isFalse);
    });
  });

  group('HTicketcherPainter.shouldRepaint', () {
    test('content-equal but distinct list instances ⇒ false', () {
      final a = _hp(widths: <double>[100.0, 200.0]);
      final b = _hp(widths: <double>[100.0, 200.0]);
      expect(b.shouldRepaint(a), isFalse);
    });

    test('different section count ⇒ true', () {
      final a = _hp();
      final b = _hp(
        widths: <double>[80, 80, 80],
        sections: const [
          Section(child: Text('A')),
          Section(child: Text('B')),
          Section(child: Text('C')),
        ],
      );
      expect(b.shouldRepaint(a), isTrue);
    });

    test('semantically-equal watermark in decoration ⇒ false', () {
      const aDec = TicketcherDecoration(
        watermark: TicketWatermark.text(text: 'CONFIDENTIAL'),
      );
      const bDec = TicketcherDecoration(
        watermark: TicketWatermark.text(text: 'CONFIDENTIAL'),
      );
      final a = _hp(decoration: aDec);
      final b = _hp(decoration: bDec);
      expect(b.shouldRepaint(a), isFalse);
    });
  });
}
