import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

Future<void> pumpTicket(WidgetTester tester, Widget ticket) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: Center(child: ticket))),
  );
  // Second pump lets the post-frame section measurement pass repaint.
  await tester.pump();
}

const _twoSections = <Section>[
  Section(child: Text('A'), padding: EdgeInsets.all(16)),
  Section(child: Text('B'), padding: EdgeInsets.all(16)),
];

void main() {
  testWidgets('multi-shadow ticket paints without errors', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          shadows: [
            BoxShadow(color: Colors.indigo, blurRadius: 8, offset: Offset(0, 4)),
            BoxShadow(color: Colors.pink, blurRadius: 16, offset: Offset(0, 10)),
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('multi-shadow horizontal ticket paints without errors',
      (tester) async {
    await pumpTicket(
      tester,
      HTicketcher(
        sections: _twoSections,
        decoration: const TicketcherDecoration(
          shadows: [
            BoxShadow(color: Colors.indigo, blurRadius: 8, offset: Offset(0, 4)),
            BoxShadow(color: Colors.pink, blurRadius: 16, offset: Offset(0, 10)),
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty shadows list suppresses legacy shadow without errors',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          shadow: BoxShadow(color: Colors.black, blurRadius: 8),
          shadows: [],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('per-boundary dividers paint without errors (V, 3 sections)',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        sections: [
          Section(
            child: const Text('A'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.tearLine(
              color: Colors.grey,
              dashWidth: 5,
              dashSpace: 4,
            ),
          ),
          Section(
            child: const Text('B'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.smoothWave(
              color: Colors.purple,
              waveHeight: 6,
              waveWidth: 10,
            ),
          ),
          const Section(child: Text('C'), padding: EdgeInsets.all(16)),
        ],
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('dividerAfter without decoration divider paints (H)',
      (tester) async {
    await pumpTicket(
      tester,
      HTicketcher(
        sections: [
          Section(
            child: const Text('A'),
            padding: const EdgeInsets.all(16),
            dividerAfter: TicketDivider.dashed(color: Colors.grey),
          ),
          const Section(child: Text('B'), padding: EdgeInsets.all(16)),
        ],
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashed gradient border paints without errors', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: const TicketcherDecoration(
          borderGradient: LinearGradient(colors: [Colors.amber, Colors.red]),
          borderWidth: 2,
          borderDash: BorderDash(dash: 7, gap: 5),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashed solid border paints without errors (H)', (tester) async {
    await pumpTicket(
      tester,
      HTicketcher(
        sections: _twoSections,
        decoration: const TicketcherDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.teal, width: 2)),
          borderDash: BorderDash(dash: 6, gap: 4),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
