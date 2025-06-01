import 'border_shape.dart';

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
