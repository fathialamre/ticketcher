import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

import '../helpers/widget_pump.dart';

void main() {
  testWidgets('HTicketcher pumps with two sections', (tester) async {
    await pumpTicket(
      tester,
      HTicketcher(
        height: 120,
        sections: const [
          Section(child: Text('Left')),
          Section(child: Text('Right')),
        ],
      ),
    );

    expect(find.text('Left'), findsOneWidget);
    expect(find.text('Right'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HTicketcher asserts on fewer than 2 sections', (tester) async {
    expect(
      () => HTicketcher(
        height: 120,
        sections: const [Section(child: Text('Only'))],
      ),
      throwsAssertionError,
    );
  });
}
