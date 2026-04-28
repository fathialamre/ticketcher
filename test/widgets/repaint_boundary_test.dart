import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  testWidgets('VTicketcher wraps CustomPaint in a RepaintBoundary',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: VTicketcher(
              width: 300,
              sections: const [
                Section(child: Text('A')),
                Section(child: Text('B')),
              ],
            ),
          ),
        ),
      ),
    );

    final repaintBoundaries = find.descendant(
      of: find.byType(VTicketcher),
      matching: find.byType(RepaintBoundary),
    );
    expect(repaintBoundaries, findsAtLeastNWidgets(1));
  });

  testWidgets('HTicketcher wraps CustomPaint in a RepaintBoundary',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: HTicketcher(
              height: 120,
              sections: const [
                Section(child: Text('L')),
                Section(child: Text('R')),
              ],
            ),
          ),
        ),
      ),
    );

    final repaintBoundaries = find.descendant(
      of: find.byType(HTicketcher),
      matching: find.byType(RepaintBoundary),
    );
    expect(repaintBoundaries, findsAtLeastNWidgets(1));
  });

  testWidgets(
    'Ancestor setState does not trigger a ticket layer repaint',
    (tester) async {
      final key = GlobalKey();
      int outerBuilds = 0;

      late StateSetter setOuter;
      Color outerColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                setOuter = setState;
                outerBuilds++;
                return Container(
                  color: outerColor,
                  alignment: Alignment.center,
                  child: VTicketcher(
                    key: key,
                    width: 300,
                    sections: const [
                      Section(child: Text('A')),
                      Section(child: Text('B')),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Wait for the post-frame measurement setState in VTicketcher to settle.
      await tester.pumpAndSettle();

      final renderObject = tester.renderObject(
        find.descendant(
          of: find.byKey(key),
          matching: find.byType(RepaintBoundary),
        ),
      );
      expect(renderObject, isA<RenderRepaintBoundary>());
      final boundary = renderObject as RenderRepaintBoundary;

      // Snapshot baseline.
      final paintsBefore = boundary.debugSymmetricPaintCount;

      // Drive 5 ancestor rebuilds with no decoration changes.
      for (int i = 0; i < 5; i++) {
        setOuter(() {
          outerColor = i.isEven ? Colors.green : Colors.blue;
        });
        await tester.pump();
      }

      final paintsAfter = boundary.debugSymmetricPaintCount;
      expect(outerBuilds, greaterThan(1));
      expect(paintsAfter, paintsBefore,
          reason: 'Ticket layer should not repaint on ancestor rebuilds.');
    },
  );
}
