import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

import '../helpers/widget_pump.dart';

const _sections = <Section>[
  Section(child: Text('A')),
  Section(child: Text('B')),
];

void main() {
  testWidgets('VTicketcher with stitch renders without throwing',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: const TicketcherDecoration(
          stitch: TicketStitch(color: Colors.white, inset: 10),
        ),
        sections: _sections,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('HTicketcher with stitch renders without throwing',
      (tester) async {
    await pumpTicket(
      tester,
      Ticketcher.horizontal(
        height: 140,
        decoration: const TicketcherDecoration(
          stitch: TicketStitch(color: Colors.white, inset: 10),
        ),
        sections: _sections,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('stitch coexists with a solid border', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        decoration: TicketcherDecoration(
          border: Border.all(color: Colors.indigo, width: 2),
          stitch: const TicketStitch(color: Colors.white, inset: 10),
        ),
        sections: _sections,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('degenerate inset is skipped without throwing', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 60,
        decoration: const TicketcherDecoration(
          stitch: TicketStitch(inset: 200),
        ),
        sections: _sections,
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
