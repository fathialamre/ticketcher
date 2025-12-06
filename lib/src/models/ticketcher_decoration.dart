import 'package:flutter/material.dart';
import 'border_pattern.dart';
import 'blur_effect.dart';
import 'notch_shape.dart';
import 'ticket_divider.dart';
import 'ticket_radius.dart';
import 'ticket_watermark.dart';

/// A class that defines the stacked layers effect for a ticket.
///
/// This class groups all properties related to the stacked layers effect,
/// including the number of layers, offset, width step, and color.
///
/// Example:
/// ```dart
/// StackEffect(
///   count: 2,
///   offset: 12.0,
///   widthStep: 10.0,
///   color: Colors.grey.withOpacity(0.2),
/// )
/// ```
class StackEffect {
  /// Maximum number of stacked layers allowed
  static const int maxCount = 3;

  /// The number of stacked layers to display
  final int count;

  /// The vertical offset between each stacked layer
  final double offset;

  /// The width reduction for each stacked layer
  final double widthStep;

  /// The color of the stacked layers
  final Color? color;

  const StackEffect({
    this.count = 0,
    this.offset = 10.0,
    this.widthStep = 10.0,
    this.color,
  }) : assert(
         count >= 0 && count <= maxCount,
         'Stack count must be between 0 and $maxCount',
       );

  StackEffect copyWith({
    int? count,
    double? offset,
    double? widthStep,
    Color? color,
  }) {
    return StackEffect(
      count: count ?? this.count,
      offset: offset ?? this.offset,
      widthStep: widthStep ?? this.widthStep,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StackEffect &&
        other.count == count &&
        other.offset == offset &&
        other.widthStep == widthStep &&
        other.color == color;
  }

  @override
  int get hashCode => Object.hash(count, offset, widthStep, color);
}

/// A decoration class for customizing the appearance of a ticket widget.
///
/// Example:
/// ```dart
/// TicketcherDecoration(
///   borderRadius: TicketRadius(radius: 12.0),
///   backgroundColor: Colors.blue,
///   divider: TicketDivider(
///     height: 2.0,
///     color: Colors.white,
///     pattern: DashPattern(dashLength: 5, gapLength: 3),
///   ),
///   bottomBorderStyle: BorderPattern.zigzag(
///     amplitude: 8,
///     wavelength: 16,
///   ),
/// )
/// ```
///
/// The decoration allows customization of:
/// * Border radius at corners using [borderRadius]
/// * Background color, gradient, or image using [backgroundColor], [gradient], or [backgroundImage]
/// * Border styling with solid colors using [border] or gradient colors using [borderGradient] and [borderWidth]
/// * Custom border patterns on bottom/left/right using [bottomBorderStyle], etc.
/// * Optional divider line with custom pattern using [divider]
/// * Border and shadow effects using [border] and [shadow]
/// * Stacked layers effect using [stackEffect]
/// * Blur and glassmorphism effects using [blurEffect]
/// * Custom notch shapes using [notchStyle]
class TicketcherDecoration {
  /// Maximum number of stacked layers allowed
  static const int maxStackCount = 3;

  final TicketRadius borderRadius;
  final Border? border;
  final Gradient? borderGradient;
  final double borderWidth;
  final Color backgroundColor;
  final Gradient? gradient;
  final TicketDivider? divider;
  final BorderPattern? bottomBorderStyle;
  final BorderPattern? leftBorderStyle;
  final BorderPattern? rightBorderStyle;
  final BoxShadow? shadow;
  final StackEffect stackEffect;
  final TicketWatermark? watermark;
  final BlurEffect? blurEffect;

  /// The style of the notches between sections.
  ///
  /// If null, uses the default semicircle notch with the radius
  /// specified in the widget's [notchRadius] parameter.
  final NotchStyle? notchStyle;

  /// The image to use as the background
  final ImageProvider? backgroundImage;

  /// How the background image should be inscribed into the space
  final BoxFit backgroundImageFit;

  /// The opacity of the background image (0.0 to 1.0)
  final double backgroundImageOpacity;

  /// How to align the background image within its bounds
  final Alignment backgroundImageAlignment;

  const TicketcherDecoration({
    this.borderRadius = const TicketRadius(radius: 8.0),
    this.border,
    this.borderGradient,
    this.borderWidth = 1.0,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.divider,
    this.bottomBorderStyle,
    this.leftBorderStyle,
    this.rightBorderStyle,
    this.shadow,
    this.stackEffect = const StackEffect(),
    this.watermark,
    this.blurEffect,
    this.backgroundImage,
    this.backgroundImageFit = BoxFit.cover,
    this.backgroundImageOpacity = 1.0,
    this.backgroundImageAlignment = Alignment.center,
    this.notchStyle,
  }) : assert(
         backgroundImageOpacity >= 0.0 && backgroundImageOpacity <= 1.0,
         'backgroundImageOpacity must be between 0.0 and 1.0',
       );

  TicketcherDecoration copyWith({
    TicketRadius? borderRadius,
    Border? border,
    Gradient? borderGradient,
    double? borderWidth,
    Color? backgroundColor,
    Gradient? gradient,
    TicketDivider? divider,
    BorderPattern? bottomBorderStyle,
    BorderPattern? leftBorderStyle,
    BorderPattern? rightBorderStyle,
    BoxShadow? shadow,
    StackEffect? stackEffect,
    TicketWatermark? watermark,
    BlurEffect? blurEffect,
    ImageProvider? backgroundImage,
    BoxFit? backgroundImageFit,
    double? backgroundImageOpacity,
    Alignment? backgroundImageAlignment,
    NotchStyle? notchStyle,
  }) {
    return TicketcherDecoration(
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      borderGradient: borderGradient ?? this.borderGradient,
      borderWidth: borderWidth ?? this.borderWidth,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      divider: divider ?? this.divider,
      bottomBorderStyle: bottomBorderStyle ?? this.bottomBorderStyle,
      leftBorderStyle: leftBorderStyle ?? this.leftBorderStyle,
      rightBorderStyle: rightBorderStyle ?? this.rightBorderStyle,
      shadow: shadow ?? this.shadow,
      stackEffect: stackEffect ?? this.stackEffect,
      watermark: watermark ?? this.watermark,
      blurEffect: blurEffect ?? this.blurEffect,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      backgroundImageFit: backgroundImageFit ?? this.backgroundImageFit,
      backgroundImageOpacity:
          backgroundImageOpacity ?? this.backgroundImageOpacity,
      backgroundImageAlignment:
          backgroundImageAlignment ?? this.backgroundImageAlignment,
      notchStyle: notchStyle ?? this.notchStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketcherDecoration &&
        other.borderRadius == borderRadius &&
        other.border == border &&
        other.borderGradient == borderGradient &&
        other.borderWidth == borderWidth &&
        other.backgroundColor == backgroundColor &&
        other.gradient == gradient &&
        other.divider == divider &&
        other.bottomBorderStyle == bottomBorderStyle &&
        other.leftBorderStyle == leftBorderStyle &&
        other.rightBorderStyle == rightBorderStyle &&
        other.shadow == shadow &&
        other.stackEffect == stackEffect &&
        other.watermark == watermark &&
        other.blurEffect == blurEffect &&
        other.backgroundImage == backgroundImage &&
        other.backgroundImageFit == backgroundImageFit &&
        other.backgroundImageOpacity == backgroundImageOpacity &&
        other.backgroundImageAlignment == backgroundImageAlignment &&
        other.notchStyle == notchStyle;
  }

  @override
  int get hashCode => Object.hashAll([
    borderRadius,
    border,
    borderGradient,
    borderWidth,
    backgroundColor,
    gradient,
    divider,
    bottomBorderStyle,
    leftBorderStyle,
    rightBorderStyle,
    shadow,
    stackEffect,
    watermark,
    blurEffect,
    backgroundImage,
    backgroundImageFit,
    backgroundImageOpacity,
    backgroundImageAlignment,
    notchStyle,
  ]);
}
