import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

import '../helpers/widget_pump.dart';

void main() {
  testWidgets('VTicketcher pumps with two sections', (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        sections: const [
          Section(child: Text('Top')),
          Section(child: Text('Bottom')),
        ],
      ),
    );

    expect(find.text('Top'), findsOneWidget);
    expect(find.text('Bottom'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('VTicketcher asserts on fewer than 2 sections', (tester) async {
    expect(
      () => VTicketcher(
        sections: const [Section(child: Text('Only'))],
      ),
      throwsAssertionError,
    );
  });
}
