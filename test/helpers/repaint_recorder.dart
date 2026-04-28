import 'package:flutter/material.dart';

/// A [CustomPainter] that counts how many times [paint] is called.
///
/// Wrap real painters or use as a child painter to verify
/// [RepaintBoundary] behavior in tests.
class CountingPainter extends CustomPainter {
  int paintCount = 0;
  final CustomPainter? inner;

  CountingPainter({this.inner});

  @override
  void paint(Canvas canvas, Size size) {
    paintCount++;
    inner?.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
