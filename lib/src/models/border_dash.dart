import 'package:flutter/foundation.dart';

/// Defines a dash pattern for the ticket's outer border.
///
/// When set on `TicketcherDecoration.borderDash` together with an active
/// border (`border` or `borderGradient`), the ticket outline is stroked as
/// dashes instead of a solid line. The dashing follows the full outline —
/// corners, notches, and border patterns included.
///
/// Has no effect when neither `border` nor `borderGradient` is set.
///
/// Example:
/// ```dart
/// TicketcherDecoration(
///   border: Border.all(color: Colors.amber, width: 2),
///   borderDash: BorderDash(dash: 7, gap: 5),
/// )
/// ```
@immutable
class BorderDash {
  /// The length of each dash segment in logical pixels. Must be > 0.
  final double dash;

  /// The gap between dash segments in logical pixels. Must be > 0.
  final double gap;

  // `< double.infinity` (rather than `.isFinite`) keeps the assert
  // const-evaluable; NaN already fails the `> 0` check.
  const BorderDash({required this.dash, required this.gap})
      : assert(
          dash > 0 && dash < double.infinity,
          'dash must be a finite positive number',
        ),
        assert(
          gap > 0 && gap < double.infinity,
          'gap must be a finite positive number',
        );

  BorderDash copyWith({double? dash, double? gap}) {
    return BorderDash(dash: dash ?? this.dash, gap: gap ?? this.gap);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BorderDash && other.dash == dash && other.gap == gap;
  }

  @override
  int get hashCode => Object.hash(dash, gap);
}
