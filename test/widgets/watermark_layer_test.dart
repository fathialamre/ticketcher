import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/painters/vticketcher_painter.dart';
import 'package:ticketcher/src/painters/hticketcher_painter.dart';

import '../helpers/widget_pump.dart';

const _wmKey = Key('wm');

const _sections = <Section>[
  Section(child: Text('A')),
  Section(child: Text('B')),
];

const _watermark = TicketWatermark.widget(
  widget: SizedBox(
    key: _wmKey,
    width: 24,
    height: 24,
    child: ColoredBox(color: Color(0xFFFF0000)),
  ),
  alignment: WatermarkAlignment.center,
  opacity: 0.5,
);

void main() {
  testWidgets(
    'vertical: widget watermark renders in the background layer, clipped to the ticket shape',
    (tester) async {
      await pumpTicket(
        tester,
        VTicketcher(
          width: 300,
          decoration: const TicketcherDecoration(watermark: _watermark),
          sections: _sections,
        ),
      );
      await tester.pump();

      expect(find.byKey(_wmKey), findsOneWidget);

      // Background layer: the watermark lives INSIDE the painter's CustomPaint
      // (behind the section content), not as a foreground sibling overlay.
      final painter = find.byWidgetPredicate(
        (w) => w is CustomPaint && w.painter is VTicketcherPainter,
      );
      expect(
        find.descendant(of: painter, matching: find.byKey(_wmKey)),
        findsOneWidget,
      );

      // Clipped to the ticket outline (notches + corners).
      final clip = find.byWidgetPredicate(
        (w) => w is ClipPath && w.clipper is VTicketcherClipper,
      );
      expect(
        find.ancestor(of: find.byKey(_wmKey), matching: clip),
        findsAtLeastNWidgets(1),
      );
    },
  );

  testWidgets(
    'horizontal: widget watermark renders in the background layer, clipped to the ticket shape',
    (tester) async {
      await pumpTicket(
        tester,
        Ticketcher.horizontal(
          height: 160,
          decoration: const TicketcherDecoration(watermark: _watermark),
          sections: _sections,
        ),
      );
      await tester.pump();

      expect(find.byKey(_wmKey), findsOneWidget);

      final painter = find.byWidgetPredicate(
        (w) => w is CustomPaint && w.painter is HTicketcherPainter,
      );
      expect(
        find.descendant(of: painter, matching: find.byKey(_wmKey)),
        findsOneWidget,
      );

      final clip = find.byWidgetPredicate(
        (w) => w is ClipPath && w.clipper is HTicketcherClipper,
      );
      expect(
        find.ancestor(of: find.byKey(_wmKey), matching: clip),
        findsAtLeastNWidgets(1),
      );
    },
  );
}
