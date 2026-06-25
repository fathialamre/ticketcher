import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/painters/vticketcher_painter.dart';
import 'package:ticketcher/src/painters/hticketcher_painter.dart';

// Records drawPath calls; ignores every other Canvas operation.
class _RecordingCanvas implements Canvas {
  int drawPathCount = 0;
  final List<Paint> drawPathPaints = <Paint>[];

  @override
  void drawPath(Path path, Paint paint) {
    drawPathCount++;
    drawPathPaints.add(Paint()
      ..style = paint.style
      ..color = paint.color
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = paint.strokeCap);
  }

  @override
  void noSuchMethod(Invocation invocation) {}
}

const _sections = <Section>[
  Section(child: Text('A')),
  Section(child: Text('B')),
];

void main() {
  test('VTicketcherPainter draws an extra stroked path when stitch is set', () {
    const size = Size(300, 400);

    final without = _RecordingCanvas();
    VTicketcherPainter(
      notchRadius: 10,
      sectionHeights: const [200, 200],
      decoration: const TicketcherDecoration(),
      sections: _sections,
    ).paint(without, size);

    final withStitch = _RecordingCanvas();
    VTicketcherPainter(
      notchRadius: 10,
      sectionHeights: const [200, 200],
      decoration: const TicketcherDecoration(
        stitch: TicketStitch(color: Colors.white, inset: 10),
      ),
      sections: _sections,
    ).paint(withStitch, size);

    expect(withStitch.drawPathCount, greaterThan(without.drawPathCount));
    expect(
      withStitch.drawPathPaints.any((p) =>
          p.style == PaintingStyle.stroke &&
          p.color == const Color(0xFFFFFFFF)),
      isTrue,
    );
  });

  test('HTicketcherPainter draws an extra stroked path when stitch is set', () {
    const size = Size(400, 200);

    final without = _RecordingCanvas();
    HTicketcherPainter(
      notchRadius: 10,
      sectionWidths: const [200, 200],
      decoration: const TicketcherDecoration(),
      sections: _sections,
    ).paint(without, size);

    final withStitch = _RecordingCanvas();
    HTicketcherPainter(
      notchRadius: 10,
      sectionWidths: const [200, 200],
      decoration: const TicketcherDecoration(
        stitch: TicketStitch(color: Colors.white, inset: 10),
      ),
      sections: _sections,
    ).paint(withStitch, size);

    expect(withStitch.drawPathCount, greaterThan(without.drawPathCount));
    expect(
      withStitch.drawPathPaints.any((p) =>
          p.style == PaintingStyle.stroke &&
          p.color == const Color(0xFFFFFFFF)),
      isTrue,
    );
  });

  test('degenerate inset skips the stitch draw (no extra path)', () {
    const size = Size(60, 400); // shortestSide 60; inset*2 = 400 >= 60 → skip

    final baseline = _RecordingCanvas();
    VTicketcherPainter(
      notchRadius: 10,
      sectionHeights: const [200, 200],
      decoration: const TicketcherDecoration(),
      sections: _sections,
    ).paint(baseline, size);

    final degenerate = _RecordingCanvas();
    VTicketcherPainter(
      notchRadius: 10,
      sectionHeights: const [200, 200],
      decoration: const TicketcherDecoration(stitch: TicketStitch(inset: 200)),
      sections: _sections,
    ).paint(degenerate, size);

    expect(degenerate.drawPathCount, baseline.drawPathCount);
  });
}
