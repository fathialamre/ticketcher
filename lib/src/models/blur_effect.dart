import 'package:flutter/material.dart';

/// Defines the style of blur effect to apply
enum BlurStyle {
  /// Standard backdrop filter blur - blurs content behind the ticket
  backdrop,

  /// Frosted glass effect - backdrop blur with tinted overlay
  frosted,

  /// Gaussian blur - applies blur to the ticket itself
  gaussian,
}

/// A class that defines blur and glassmorphism effects for a ticket.
///
/// This class provides configuration for modern blur effects including
/// backdrop filters, frosted glass, and gaussian blur styles.
///
/// Example:
/// ```dart
/// // Frosted glass effect
/// BlurEffect(
///   sigma: 10.0,
///   style: BlurStyle.frosted,
///   tintColor: Colors.white,
///   opacity: 0.2,
/// )
///
/// // Simple backdrop blur
/// BlurEffect.backdrop(sigma: 15.0)
///
/// // Gaussian blur on ticket content
/// BlurEffect.gaussian(sigma: 5.0)
/// ```
class BlurEffect {
  /// The intensity of the blur effect (standard deviation for Gaussian blur)
  /// Higher values create more blur. Typical range: 0-30
  final double sigma;

  /// The style of blur to apply
  final BlurStyle style;

  /// Optional tint color for frosted glass effect
  /// Only used when style is [BlurStyle.frosted]
  final Color? tintColor;

  /// Opacity of the tint color overlay (0.0 - 1.0)
  /// Only used when style is [BlurStyle.frosted]
  final double opacity;

  const BlurEffect({
    this.sigma = 10.0,
    this.style = BlurStyle.backdrop,
    this.tintColor,
    this.opacity = 0.2,
  }) : assert(sigma >= 0, 'Sigma must be non-negative'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'Opacity must be between 0.0 and 1.0',
       );

  /// Creates a backdrop blur effect
  const BlurEffect.backdrop({double sigma = 10.0})
    : this(sigma: sigma, style: BlurStyle.backdrop);

  /// Creates a frosted glass effect with tint
  const BlurEffect.frosted({
    double sigma = 10.0,
    Color tintColor = Colors.white,
    double opacity = 0.2,
  }) : this(
         sigma: sigma,
         style: BlurStyle.frosted,
         tintColor: tintColor,
         opacity: opacity,
       );

  /// Creates a gaussian blur effect
  const BlurEffect.gaussian({double sigma = 5.0})
    : this(sigma: sigma, style: BlurStyle.gaussian);

  BlurEffect copyWith({
    double? sigma,
    BlurStyle? style,
    Color? tintColor,
    double? opacity,
  }) {
    return BlurEffect(
      sigma: sigma ?? this.sigma,
      style: style ?? this.style,
      tintColor: tintColor ?? this.tintColor,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlurEffect &&
        other.sigma == sigma &&
        other.style == style &&
        other.tintColor == tintColor &&
        other.opacity == opacity;
  }

  @override
  int get hashCode {
    return Object.hash(sigma, style, tintColor, opacity);
  }
}
