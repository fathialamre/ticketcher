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

  testWidgets('topBorderStyle with top radius asserts', (tester) async {
    expect(
      () => VTicketcher(
        sections: _twoSections,
        decoration: const TicketcherDecoration(
          topBorderStyle: BorderPattern(shape: BorderShape.sharp),
          borderRadius: TicketRadius(radius: 8, corner: TicketCorner.top),
        ),
      ),
      throwsAssertionError,
    );
  });

  testWidgets('topBorderStyle paints without errors for all three shapes',
      (tester) async {
    for (final shape in [BorderShape.wave, BorderShape.sharp, BorderShape.arc]) {
      await pumpTicket(
        tester,
        VTicketcher(
          sections: _twoSections,
          width: 300,
          decoration: TicketcherDecoration(
            borderRadius: TicketRadius.zero,
            topBorderStyle: BorderPattern(shape: shape, height: 8, width: 20),
          ),
        ),
      );
      expect(tester.takeException(), isNull, reason: 'shape: $shape');
    }
  });

  testWidgets('all five 2.1.0 features combined on one vertical ticket paint',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        sections: [
          Section(
            child: const Text('A'),
            padding: const EdgeInsets.all(16),
            color: Colors.amber.shade50,
            dividerAfter: TicketDivider.tearLine(
              color: Colors.grey,
              dashWidth: 5,
              dashSpace: 4,
            ),
          ),
          const Section(
            child: Text('B'),
            padding: EdgeInsets.all(16),
            gradient: LinearGradient(colors: [Colors.white, Colors.purple]),
            // No dividerAfter: boundary 1 falls back to decoration.divider.
          ),
          const Section(child: Text('C'), padding: EdgeInsets.all(16)),
        ],
        decoration: TicketcherDecoration(
          borderRadius: TicketRadius.zero,
          topBorderStyle:
              const BorderPattern(shape: BorderShape.sharp, height: 8, width: 20),
          bottomBorderStyle:
              const BorderPattern(shape: BorderShape.wave, height: 8, width: 20),
          border: const Border.fromBorderSide(
            BorderSide(color: Colors.deepPurple, width: 2),
          ),
          borderDash: const BorderDash(dash: 7, gap: 5),
          shadows: const [
            BoxShadow(color: Colors.indigo, blurRadius: 8, offset: Offset(0, 4)),
            BoxShadow(color: Colors.pink, blurRadius: 16, offset: Offset(0, 10)),
          ],
          punchHoles: const [
            PunchHole(
              alignment: Alignment.topCenter,
              offset: Offset(0, 24),
              radius: 7,
            ),
            PunchHole(
              alignment: Alignment.bottomLeft,
              offset: Offset(20, -20),
              radius: 6,
              shape: NotchShape.diamond,
            ),
          ],
          divider: TicketDivider.dashed(color: Colors.grey),
          watermark: const TicketWatermark.text(text: 'VOID', repeat: true),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('punch holes paint without errors (V and H)', (tester) async {
    const holeDecoration = TicketcherDecoration(
      border: Border.fromBorderSide(BorderSide(color: Colors.purple)),
      punchHoles: [
        PunchHole(alignment: Alignment.topCenter, offset: Offset(0, 15), radius: 7),
        PunchHole(
          alignment: Alignment.bottomRight,
          offset: Offset(-20, -20),
          radius: 6,
          shape: NotchShape.diamond,
        ),
      ],
    );
    await pumpTicket(
      tester,
      VTicketcher(
        sections: _twoSections,
        width: 300,
        decoration: holeDecoration,
      ),
    );
    expect(tester.takeException(), isNull);

    await pumpTicket(
      tester,
      HTicketcher(sections: _twoSections, decoration: holeDecoration),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('dividerAfter on the last section is ignored without errors',
      (tester) async {
    await pumpTicket(
      tester,
      VTicketcher(
        width: 300,
        sections: [
          const Section(child: Text('A'), padding: EdgeInsets.all(16)),
          Section(
            child: const Text('B'),
            padding: const EdgeInsets.all(16),
            // No boundary after the last section — this must be a no-op.
            dividerAfter: TicketDivider.solid(color: Colors.red),
          ),
        ],
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
