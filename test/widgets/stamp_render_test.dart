import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

import '../helpers/widget_pump.dart';

const _sections = <Section>[
  Section(child: SizedBox(height: 80, child: Text('A'))),
  Section(child: SizedBox(height: 60, child: Text('B'))),
];

Finder _clipOf<T>() => find.byWidgetPredicate(
      (w) => w is ClipPath && w.clipper is T,
    );

void main() {
  testWidgets('vertical: stamp is drawn above content, clipped, non-interactive',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(stamp: TicketStamp.used()),
        sections: _sections,
      ),
    );
    await tester.pump();

    final mark = find.byType(TicketStampMark);
    expect(mark, findsOneWidget);
    expect(
      find.ancestor(of: mark, matching: _clipOf<VTicketcherClipper>()),
      findsOneWidget,
    );
    expect(
      find.ancestor(of: mark, matching: find.byType(IgnorePointer)),
      findsAtLeastNWidgets(1),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('horizontal: stamp is clipped by the horizontal clipper',
      (tester) async {
    await pumpTicket(
      tester,
      Ticketcher.horizontal(
        height: 160,
        decoration: const TicketcherDecoration(
          stamp: TicketStamp(text: 'VIP', shape: StampShape.hexagon),
        ),
        sections: const [
          Section(child: Text('A')),
          Section(child: Text('B')),
        ],
      ),
    );
    await tester.pump();

    expect(
      find.ancestor(
        of: find.byType(TicketStampMark),
        matching: _clipOf<HTicketcherClipper>(),
      ),
      findsOneWidget,
    );
  });

  testWidgets('stamp exposes its text to screen readers', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(
          stamp: TicketStamp.used(subtitle: '14 DEC'),
        ),
        sections: _sections,
      ),
    );
    expect(find.bySemanticsLabel('USED, 14 DEC'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('section taps pass through the stamp', (tester) async {
    var taps = 0;
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(stamp: TicketStamp.voided()),
        sections: [
          Section(
            onTap: () => taps++,
            child: const SizedBox(height: 80, child: Text('A')),
          ),
          const Section(child: SizedBox(height: 60, child: Text('B'))),
        ],
      ),
    );
    await tester.tap(find.text('A'));
    expect(taps, 1);
  });

  testWidgets('no stamp and active status adds no layers', (tester) async {
    await pumpTicket(tester, VTicketcher(width: 300, sections: _sections));
    expect(find.byType(TicketStampMark), findsNothing);
    expect(find.byType(ColorFiltered), findsNothing);
  });

  testWidgets('expired greys the ticket but not the stamp', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(
          status: TicketStatus.expired,
          stamp: TicketStamp.voided(),
        ),
        sections: _sections,
      ),
    );

    final filter = find.byType(ColorFiltered);
    expect(filter, findsOneWidget);
    expect(
      find.descendant(of: filter, matching: find.text('A')),
      findsOneWidget,
    );
    expect(
      find.ancestor(of: find.byType(TicketStampMark), matching: filter),
      findsNothing,
    );
  });

  testWidgets('animateIn plays and settles', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(
          stamp: TicketStamp.used(animateIn: true),
        ),
        sections: _sections,
      ),
    );
    final transition = find.descendant(
      of: find.byType(TicketStampMark),
      matching: find.byType(ScaleTransition),
    );
    expect(transition, findsOneWidget);
    expect(tester.widget<ScaleTransition>(transition).scale.value,
        greaterThan(1.0));
    await tester.pumpAndSettle();
    expect(tester.widget<ScaleTransition>(transition).scale.value, 1.0);
  });

  testWidgets('animateIn is skipped when animations are disabled',
      (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: VTicketcher(
                width: 300,
                decoration: const TicketcherDecoration(
                  stamp: TicketStamp.used(animateIn: true),
                ),
                sections: _sections,
              ),
            ),
          ),
        ),
      ),
    );
    expect(
      find.descendant(
        of: find.byType(TicketStampMark),
        matching: find.byType(ScaleTransition),
      ),
      findsNothing,
    );
  });

  testWidgets('TicketStampMark works standalone with Arabic text',
      (tester) async {
    await pumpTicket(
      tester,
      const Directionality(
        textDirection: TextDirection.rtl,
        child: TicketStampMark(
          stamp: TicketStamp(text: 'مُستخدَمة', shape: StampShape.ribbon),
        ),
      ),
    );
    final size = tester.getSize(find.byType(TicketStampMark));
    expect(size.width, greaterThan(0));
    expect(tester.takeException(), isNull);
  });
}
