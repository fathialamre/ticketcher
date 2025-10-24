import 'package:flutter/material.dart';
import 'border_pattern.dart';
import 'blur_effect.dart';
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
/// * Background color or gradient using [backgroundColor] or [gradient]
/// * Border styling with solid colors using [border] or gradient colors using [borderGradient] and [borderWidth]
/// * Custom border patterns on bottom/left/right using [bottomBorderStyle], etc.
/// * Optional divider line with custom pattern using [divider]
/// * Border and shadow effects using [border] and [shadow]
/// * Stacked layers effect using [stackEffect]
/// * Blur and glassmorphism effects using [blurEffect]
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
  });

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
    );
  }
}
