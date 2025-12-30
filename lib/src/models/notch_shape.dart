/// Defines the available shapes for ticket notches.
///
/// Notches are the cutouts between ticket sections that create
/// the classic ticket appearance. Each shape provides a different
/// visual style for these cutouts.
enum NotchShape {
  /// A semicircular notch (default). Creates smooth, rounded cutouts.
  semicircle,

  /// A triangular notch. Creates V-shaped cutouts pointing inward.
  triangle,

  /// A square/rectangular notch. Creates rectangular cutouts.
  square,

  /// A diamond-shaped notch. Creates diamond/rhombus cutouts.
  diamond,
}

/// Configuration for ticket notch styling.
///
/// This class allows customization of the notches that appear between
/// ticket sections. You can control both the shape and size of the notches.
///
/// Example:
/// ```dart
/// NotchStyle(
///   shape: NotchShape.triangle,
///   radius: 12.0,
/// )
/// ```
class NotchStyle {
  /// The shape of the notch cutouts.
  ///
  /// Defaults to [NotchShape.semicircle] for the classic ticket look.
  final NotchShape shape;

  /// The size of the notch.
  ///
  /// For semicircle: this is the radius of the arc.
  /// For triangle: this is the depth and half-width of the triangle.
  /// For square: this is the depth and half-width of the rectangle.
  /// For diamond: this is the distance from center to each point.
  ///
  /// Defaults to 10.0.
  final double radius;

  /// Creates a new [NotchStyle].
  ///
  /// Parameters:
  /// - [shape]: The shape of the notch (default: semicircle)
  /// - [radius]: The size of the notch (default: 10.0)
  const NotchStyle({
    this.shape = NotchShape.semicircle,
    this.radius = 10.0,
  }) : assert(radius > 0, 'Notch radius must be greater than 0');

  /// Creates a semicircular notch style.
  const NotchStyle.semicircle({this.radius = 10.0})
      : shape = NotchShape.semicircle;

  /// Creates a triangular notch style.
  const NotchStyle.triangle({this.radius = 10.0})
      : shape = NotchShape.triangle;

  /// Creates a square notch style.
  const NotchStyle.square({this.radius = 10.0})
      : shape = NotchShape.square;

  /// Creates a diamond notch style.
  const NotchStyle.diamond({this.radius = 10.0})
      : shape = NotchShape.diamond;

  /// Creates a copy of this [NotchStyle] with the given fields replaced.
  NotchStyle copyWith({
    NotchShape? shape,
    double? radius,
  }) {
    return NotchStyle(
      shape: shape ?? this.shape,
      radius: radius ?? this.radius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotchStyle &&
        other.shape == shape &&
        other.radius == radius;
  }

  @override
  int get hashCode => Object.hash(shape, radius);
}

