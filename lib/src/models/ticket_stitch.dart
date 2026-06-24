import 'package:flutter/material.dart';

/// A dashed "thread" line inset from the ticket edge, following the full
/// outline (rounded corners + section notches) to create a sewn / stitched look.
///
/// Set on `TicketcherDecoration.stitch`. Independent of `border` / `borderDash`
/// — it draws as a separate inset line and does not require a border. Works in
/// both vertical and horizontal orientations.
///
/// Notches are wrapped with a smooth rounded arc regardless of
/// `notchStyle.shape` (thread curves naturally). Edge border patterns
/// (`bottomBorderStyle`, etc.) and `punchHoles` are not traced.
///
/// Keep [inset] below half the ticket's smallest dimension; beyond that the
/// inset line collapses and the stitch is not drawn.
///
/// Example:
/// ```dart
/// TicketcherDecoration(
///   stitch: TicketStitch(color: Colors.white, inset: 10, length: 6, spacing: 6),
/// )
/// ```
@immutable
class TicketStitch {
  /// Thread color. Defaults to white.
  final Color color;

  /// Distance from the ticket edge to the stitch line, in logical pixels. > 0.
  final double inset;

  /// Length of each stitch (dash) in logical pixels. > 0.
  final double length;

  /// Gap between stitches in logical pixels. > 0.
  final double spacing;

  /// Stroke width of the thread in logical pixels. > 0.
  final double thickness;

  /// Cap at each stitch end. [StrokeCap.round] gives the thread look.
  final StrokeCap cap;

  // `< double.infinity` (rather than `.isFinite`) keeps the assert
  // const-evaluable; NaN already fails the `> 0` check.
  const TicketStitch({
    this.color = Colors.white,
    this.inset = 10,
    this.length = 6,
    this.spacing = 6,
    this.thickness = 2,
    this.cap = StrokeCap.round,
  })  : assert(inset > 0 && inset < double.infinity,
            'inset must be a finite positive number'),
        assert(length > 0 && length < double.infinity,
            'length must be a finite positive number'),
        assert(spacing > 0 && spacing < double.infinity,
            'spacing must be a finite positive number'),
        assert(thickness > 0 && thickness < double.infinity,
            'thickness must be a finite positive number');

  TicketStitch copyWith({
    Color? color,
    double? inset,
    double? length,
    double? spacing,
    double? thickness,
    StrokeCap? cap,
  }) {
    return TicketStitch(
      color: color ?? this.color,
      inset: inset ?? this.inset,
      length: length ?? this.length,
      spacing: spacing ?? this.spacing,
      thickness: thickness ?? this.thickness,
      cap: cap ?? this.cap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketStitch &&
        other.color == color &&
        other.inset == inset &&
        other.length == length &&
        other.spacing == spacing &&
        other.thickness == thickness &&
        other.cap == cap;
  }

  @override
  int get hashCode =>
      Object.hash(color, inset, length, spacing, thickness, cap);
}
