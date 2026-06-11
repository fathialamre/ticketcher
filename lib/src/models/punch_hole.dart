import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'notch_shape.dart';

/// A hole punched through the ticket shape.
///
/// The hole is a true cutout: background color/gradient/image, shadows,
/// the blur clip, and the border stroke all respect it. With a border set,
/// the stroke automatically draws a ring around the hole.
///
/// Position = [alignment] resolved within the ticket rect, then nudged by
/// [offset] in logical pixels.
///
/// [shape] reuses [NotchShape]; for an interior hole, [NotchShape.semicircle]
/// renders as a full circle. [radius] is the circle radius, or the half-extent
/// for square/diamond/triangle.
///
/// Placement sanity (keeping holes away from notches, dividers, and edges)
/// is the caller's responsibility. A divider line crossing a hole paints
/// over it.
///
/// Example — lanyard hole top center:
/// ```dart
/// TicketcherDecoration(
///   punchHoles: [
///     PunchHole(alignment: Alignment.topCenter, offset: Offset(0, 15), radius: 7),
///   ],
/// )
/// ```
@immutable
class PunchHole {
  /// Where the hole sits within the ticket rectangle.
  final Alignment alignment;

  /// Pixel nudge applied after [alignment] is resolved.
  final Offset offset;

  /// Circle radius / half-extent of the hole. Must be > 0.
  final double radius;

  /// The hole shape. [NotchShape.semicircle] means a full circle here.
  final NotchShape shape;

  // `< double.infinity` (rather than `.isFinite`) keeps the assert
  // const-evaluable; NaN already fails the `> 0` check.
  const PunchHole({
    this.alignment = Alignment.topCenter,
    this.offset = Offset.zero,
    required this.radius,
    this.shape = NotchShape.semicircle,
  }) : assert(
          radius > 0 && radius < double.infinity,
          'radius must be a finite positive number',
        );

  PunchHole copyWith({
    Alignment? alignment,
    Offset? offset,
    double? radius,
    NotchShape? shape,
  }) {
    return PunchHole(
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      radius: radius ?? this.radius,
      shape: shape ?? this.shape,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PunchHole &&
        other.alignment == alignment &&
        other.offset == offset &&
        other.radius == radius &&
        other.shape == shape;
  }

  @override
  int get hashCode => Object.hash(alignment, offset, radius, shape);
}
