import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/painters/stamp_painter.dart';

Size _measure(TicketStamp stamp) => TicketStampPainter.measure(
      stamp,
      textDirection: TextDirection.ltr,
    );

void main() {
  test('measure gives a positive size for every shape', () {
    for (final shape in StampShape.values) {
      final size = _measure(TicketStamp(text: 'USED', shape: shape));
      expect(size.width, greaterThan(0), reason: '$shape');
      expect(size.height, greaterThan(0), reason: '$shape');
    }
  });

  test('circle and seal are square; seal is larger than circle', () {
    final circle = _measure(
      const TicketStamp(text: 'PAID', shape: StampShape.circle),
    );
    final seal = _measure(
      const TicketStamp(text: 'PAID', shape: StampShape.seal),
    );
    expect(circle.width, circle.height);
    expect(seal.width, seal.height);
    expect(seal.width, greaterThan(circle.width));
  });

  test('double border and subtitle enlarge the stamp', () {
    const single = TicketStamp(
      text: 'USED',
      borderStyle: StampBorderStyle.single,
    );
    final double = single.copyWith(borderStyle: StampBorderStyle.double);
    final withSubtitle = single.copyWith(subtitle: '14 DEC 2026');
    expect(_measure(double).width, greaterThan(_measure(single).width));
    expect(
      _measure(withSubtitle).height,
      greaterThan(_measure(single).height),
    );
  });

  test('paints every shape × border style without throwing', () {
    for (final shape in StampShape.values) {
      for (final style in StampBorderStyle.values) {
        for (final text in ['USED', 'مُستخدَمة']) {
          final stamp = TicketStamp(
            text: text,
            subtitle: '14 DEC',
            shape: shape,
            borderStyle: style,
          );
          final painter = TicketStampPainter(
            stamp: stamp,
            textDirection: TextDirection.ltr,
          );
          final recorder = ui.PictureRecorder();
          painter.paint(Canvas(recorder), _measure(stamp));
          recorder.endRecording().dispose();
        }
      }
    }
  });

  test('shouldRepaint compares stamp and text settings by value', () {
    TicketStampPainter p(TicketStamp s, [TextDirection d = TextDirection.ltr]) =>
        TicketStampPainter(stamp: s, textDirection: d);
    const stamp = TicketStamp.used();
    expect(p(stamp).shouldRepaint(p(const TicketStamp.used())), isFalse);
    expect(p(stamp).shouldRepaint(p(const TicketStamp.voided())), isTrue);
    expect(
      p(stamp).shouldRepaint(p(stamp, TextDirection.rtl)),
      isTrue,
    );
  });
}
