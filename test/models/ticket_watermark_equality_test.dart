import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  group('TicketWatermark equality', () {
    test('two text watermarks with same args ⇒ equal', () {
      const a = TicketWatermark.text(text: 'COPY', opacity: 0.3);
      const b = TicketWatermark.text(text: 'COPY', opacity: 0.3);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('different text ⇒ unequal', () {
      const a = TicketWatermark.text(text: 'A');
      const b = TicketWatermark.text(text: 'B');
      expect(a, isNot(equals(b)));
    });

    test('different opacity ⇒ unequal', () {
      const a = TicketWatermark.text(text: 'X', opacity: 0.2);
      const b = TicketWatermark.text(text: 'X', opacity: 0.5);
      expect(a, isNot(equals(b)));
    });

    test('different alignment ⇒ unequal', () {
      const a = TicketWatermark.text(
        text: 'X',
        alignment: WatermarkAlignment.topLeft,
      );
      const b = TicketWatermark.text(
        text: 'X',
        alignment: WatermarkAlignment.bottomRight,
      );
      expect(a, isNot(equals(b)));
    });

    test('widget watermark equal with same widget instance', () {
      const w = Icon(Icons.star);
      const a = TicketWatermark.widget(widget: w);
      const b = TicketWatermark.widget(widget: w);
      expect(a, equals(b));
    });

    test('text vs widget type ⇒ unequal', () {
      const w = Icon(Icons.star);
      const a = TicketWatermark.text(text: 'X');
      const b = TicketWatermark.widget(widget: w);
      expect(a, isNot(equals(b)));
    });
  });
}
