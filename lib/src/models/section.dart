import 'package:flutter/material.dart';

/// A widget that wraps its child with padding and optional width constraints.
///
/// Example:
/// ```dart
/// Section(
///   child: Text('Hello World'),
///   padding: EdgeInsets.all(16.0),
///   widthFactor: 0.8, // 80% of parent width
///   onTap: () => print('Section tapped!'),
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple],
///     begin: Alignment.topLeft,
///     end: Alignment.bottomRight,
///   ),
///   backgroundImage: AssetImage('assets/bg.png'),
///   backgroundImageFit: BoxFit.cover,
///   backgroundImageOpacity: 0.8,
/// )
/// ```
///
/// The [child] parameter is required and specifies the widget to be wrapped.
/// The [padding] parameter defaults to EdgeInsets.all(1.0) and adds space around the child.
/// The [widthFactor] parameter is optional and constrains the width as a fraction of the parent width.
/// The [onTap] parameter is optional and defines a callback function that gets executed when the section is tapped.
/// The [backgroundImage] parameter is optional and specifies an image to use as the background.
/// The [gradient] parameter is optional and specifies a gradient to use as the background.
/// The [color] parameter is optional and specifies a solid color to use as the background.
/// Background precedence: [backgroundImage] > [gradient] > [color] > decoration background

class Section {
  final Widget child;
  final EdgeInsets padding;
  final double? widthFactor;
  final Color? color;
  final VoidCallback? onTap;

  /// The gradient to use as the section background
  final Gradient? gradient;

  /// The image to use as the section background
  final ImageProvider? backgroundImage;

  /// How the background image should be inscribed into the space
  final BoxFit backgroundImageFit;

  /// The opacity of the background image (0.0 to 1.0)
  final double backgroundImageOpacity;

  /// How to align the background image within its bounds
  final Alignment backgroundImageAlignment;

  const Section({
    required this.child,
    this.padding = const EdgeInsets.all(1.0),
    this.widthFactor,
    this.color,
    this.onTap,
    this.gradient,
    this.backgroundImage,
    this.backgroundImageFit = BoxFit.cover,
    this.backgroundImageOpacity = 1.0,
    this.backgroundImageAlignment = Alignment.center,
  }) : assert(
         backgroundImageOpacity >= 0.0 && backgroundImageOpacity <= 1.0,
         'backgroundImageOpacity must be between 0.0 and 1.0',
       );

  Section copyWith({
    Widget? child,
    EdgeInsets? padding,
    double? widthFactor,
    Color? color,
    VoidCallback? onTap,
    Gradient? gradient,
    ImageProvider? backgroundImage,
    BoxFit? backgroundImageFit,
    double? backgroundImageOpacity,
    Alignment? backgroundImageAlignment,
  }) {
    return Section(
      child: child ?? this.child,
      padding: padding ?? this.padding,
      widthFactor: widthFactor ?? this.widthFactor,
      color: color ?? this.color,
      onTap: onTap ?? this.onTap,
      gradient: gradient ?? this.gradient,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      backgroundImageFit: backgroundImageFit ?? this.backgroundImageFit,
      backgroundImageOpacity:
          backgroundImageOpacity ?? this.backgroundImageOpacity,
      backgroundImageAlignment:
          backgroundImageAlignment ?? this.backgroundImageAlignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section &&
        other.padding == padding &&
        other.widthFactor == widthFactor &&
        other.color == color &&
        other.gradient == gradient &&
        other.backgroundImage == backgroundImage &&
        other.backgroundImageFit == backgroundImageFit &&
        other.backgroundImageOpacity == backgroundImageOpacity &&
        other.backgroundImageAlignment == backgroundImageAlignment;
  }

  @override
  int get hashCode => Object.hash(
    padding,
    widthFactor,
    color,
    gradient,
    backgroundImage,
    backgroundImageFit,
    backgroundImageOpacity,
    backgroundImageAlignment,
  );
}
