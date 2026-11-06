import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';

const _front = SizedBox(width: 200, height: 300, child: Text('FRONT'));
const _back = SizedBox(width: 200, height: 300, child: Text('BACK'));

Future<void> _pump(
  WidgetTester tester,
  Widget flip, {
  bool disableAnimations = false,
}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(disableAnimations: disableAnimations),
      child: MaterialApp(home: Scaffold(body: Center(child: flip))),
    ),
  );
}

/// Whether [text] is on the face currently turned toward the viewer.
bool _visible(WidgetTester tester, String text) {
  final visibility = tester.widget<Visibility>(
    find.ancestor(of: find.text(text), matching: find.byType(Visibility)),
  );
  return visibility.visible;
}

void main() {
  testWidgets('starts on the front and takes the face size', (tester) async {
    await _pump(tester, const FlipTicketcher(front: _front, back: _back));
    expect(_visible(tester, 'FRONT'), isTrue);
    expect(_visible(tester, 'BACK'), isFalse);
    expect(tester.getSize(find.byType(FlipTicketcher)), const Size(200, 300));
  });

  testWidgets('tap flips to the back and reports it', (tester) async {
    final reports = <bool>[];
    await _pump(
      tester,
      FlipTicketcher(front: _front, back: _back, onFlip: reports.add),
    );
    await tester.tap(find.byType(FlipTicketcher));
    await tester.pumpAndSettle();
    expect(_visible(tester, 'BACK'), isTrue);
    expect(reports, [false]);

    await tester.tap(find.byType(FlipTicketcher));
    await tester.pumpAndSettle();
    expect(_visible(tester, 'FRONT'), isTrue);
    expect(reports, [false, true]);
  });

  testWidgets('back face is not mirrored once flipped', (tester) async {
    await _pump(tester, const FlipTicketcher(front: _front, back: _back));
    await tester.tap(find.byType(FlipTicketcher));
    await tester.pumpAndSettle();
    // Outer half-turn × back's own half-turn = identity on screen.
    final box = tester.renderObject<RenderBox>(find.text('BACK'));
    final topLeft = box.localToGlobal(Offset.zero);
    final bottomRight = box.localToGlobal(box.size.bottomRight(Offset.zero));
    expect(bottomRight.dx, greaterThan(topLeft.dx));
  });

  testWidgets('trigger none ignores taps; controller still flips',
      (tester) async {
    final controller = FlipTicketcherController();
    await _pump(
      tester,
      FlipTicketcher(
        front: _front,
        back: _back,
        trigger: FlipTrigger.none,
        controller: controller,
      ),
    );
    await tester.tap(find.byType(FlipTicketcher), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(_visible(tester, 'FRONT'), isTrue);

    expect(controller.isAttached, isTrue);
    controller.showBack();
    await tester.pumpAndSettle();
    expect(controller.isFront, isFalse);
    expect(_visible(tester, 'BACK'), isTrue);

    controller.flip();
    await tester.pumpAndSettle();
    expect(controller.isFront, isTrue);
  });

  testWidgets('long swipe flips, short swipe springs back', (tester) async {
    await _pump(
      tester,
      const FlipTicketcher(
        front: _front,
        back: _back,
        trigger: FlipTrigger.swipe,
      ),
    );
    final center = tester.getCenter(find.byType(FlipTicketcher));

    await tester.timedDragFrom(
      center,
      const Offset(-40, 0),
      const Duration(milliseconds: 600),
    );
    await tester.pumpAndSettle();
    expect(_visible(tester, 'FRONT'), isTrue);

    await tester.timedDragFrom(
      center,
      const Offset(-150, 0),
      const Duration(milliseconds: 600),
    );
    await tester.pumpAndSettle();
    expect(_visible(tester, 'BACK'), isTrue);
  });

  testWidgets('vertical axis flips with a vertical swipe', (tester) async {
    await _pump(
      tester,
      const FlipTicketcher(
        front: _front,
        back: _back,
        axis: Axis.vertical,
        trigger: FlipTrigger.swipe,
      ),
    );
    await tester.timedDragFrom(
      tester.getCenter(find.byType(FlipTicketcher)),
      const Offset(0, -220),
      const Duration(milliseconds: 600),
    );
    await tester.pumpAndSettle();
    expect(_visible(tester, 'BACK'), isTrue);
  });

  testWidgets('reduced motion swaps faces in one frame', (tester) async {
    await _pump(
      tester,
      const FlipTicketcher(front: _front, back: _back),
      disableAnimations: true,
    );
    await tester.tap(find.byType(FlipTicketcher));
    await tester.pump();
    expect(_visible(tester, 'BACK'), isTrue);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('initiallyShowBack starts on the back', (tester) async {
    await _pump(
      tester,
      const FlipTicketcher(
        front: _front,
        back: _back,
        initiallyShowBack: true,
      ),
    );
    expect(_visible(tester, 'BACK'), isTrue);
  });

  testWidgets('controller detaches on dispose', (tester) async {
    final controller = FlipTicketcherController();
    await _pump(
      tester,
      FlipTicketcher(front: _front, back: _back, controller: controller),
    );
    expect(controller.isAttached, isTrue);
    await tester.pumpWidget(const SizedBox());
    expect(controller.isAttached, isFalse);
    expect(controller.isFront, isTrue);
    await controller.flip(); // no-op, must not throw
  });

  testWidgets('works with real tickets on both faces', (tester) async {
    Widget ticket(String label) => VTicketcher(
          width: 220,
          sections: [
            Section(child: SizedBox(height: 120, child: Text(label))),
            const Section(child: SizedBox(height: 60)),
          ],
        );
    await _pump(
      tester,
      FlipTicketcher(front: ticket('F'), back: ticket('B')),
    );
    await tester.pump();
    await tester.tap(find.byType(FlipTicketcher));
    await tester.pumpAndSettle();
    expect(_visible(tester, 'B'), isTrue);
    expect(tester.takeException(), isNull);
  });
}
