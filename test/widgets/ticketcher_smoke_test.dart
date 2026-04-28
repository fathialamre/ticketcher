import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

import '../helpers/widget_pump.dart';

void main() {
  testWidgets('Ticketcher (vertical default) pumps', (tester) async {
    await pumpTicket(
      tester,
      Ticketcher(
        width: 300,
        sections: const [
          Section(child: Text('A')),
          Section(child: Text('B')),
        ],
      ),
    );

    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Ticketcher.horizontal pumps', (tester) async {
    await pumpTicket(
      tester,
      Ticketcher.horizontal(
        height: 120,
        sections: const [
          Section(child: Text('L')),
          Section(child: Text('R')),
        ],
      ),
    );

    expect(find.text('L'), findsOneWidget);
    expect(find.text('R'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
