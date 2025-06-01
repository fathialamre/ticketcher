import 'border_shape.dart';

/// Defines a repeating border pattern with a specific shape, height and width.
///
/// Example:
/// ```dart
/// // Create a wave border pattern that is 10px high and 30px wide
/// final waveBorder = BorderPattern(
///   shape: BorderShape.wave,
///   height: 10.0,
///   width: 30.0,
/// );
///
/// // Create a copy with a different height
/// final tallerWave = waveBorder.copyWith(height: 15.0);
/// ```

class BorderPattern {
  final BorderShape shape;
  final double height;
  final double width;

  const BorderPattern({
    this.shape = BorderShape.wave,
    this.height = 8.0,
    this.width = 20.0,
  });

  BorderPattern copyWith({BorderShape? shape, double? height, double? width}) {
    return BorderPattern(
      shape: shape ?? this.shape,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
