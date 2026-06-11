import 'dart:ui';
import '../models/border_dash.dart';

/// Converts [source] into a dashed path: [BorderDash.dash]-length segments
/// separated by [BorderDash.gap]-length holes, following every contour
/// (corners, notches, border patterns) of the original.
Path dashPath(Path source, BorderDash spec) {
  final dest = Path();
  for (final metric in source.computeMetrics()) {
    double distance = 0;
    while (distance < metric.length) {
      final end = (distance + spec.dash).clamp(0.0, metric.length);
      dest.addPath(metric.extractPath(distance, end), Offset.zero);
      distance += spec.dash + spec.gap;
    }
  }
  return dest;
}
