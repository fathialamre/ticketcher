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
}
