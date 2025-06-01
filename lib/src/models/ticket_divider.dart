import 'package:flutter/material.dart';

/// Defines the available styles for ticket dividers.
///
/// Each style represents a different visual pattern that can be used to separate
/// sections in a ticket. The styles range from simple lines to complex patterns.
enum DividerStyle {
  /// A simple straight line divider.
  solid,

  /// A line made of dashes with customizable width and spacing.
  dashed,

  /// A series of circles with customizable radius and spacing.
  circles,

  /// A zigzag wave pattern with customizable height and width.
  wave,

  /// A smooth curved wave pattern with customizable height and width.
  smoothWave,

  /// A series of evenly spaced dots with customizable size and spacing.
  dotted,

  /// Two parallel lines with customizable spacing between them.
  doubleLine,
}

/// Base class for all divider styles.
///
/// This abstract class defines the common properties that all divider styles share:
/// - [color]: The color of the divider
/// - [thickness]: The thickness of the divider
/// - [padding]: The padding on both sides of the divider
abstract class BaseDividerStyle {
  /// The color of the divider.
  final Color? color;

  /// The thickness of the divider.
  final double? thickness;

  /// The padding on both sides of the divider.
  final double? padding;

  /// Creates a new [BaseDividerStyle].
  const BaseDividerStyle({this.color, this.thickness, this.padding});

  /// Returns the specific [DividerStyle] for this divider.
  DividerStyle get style;
}

/// A simple straight line divider style.
///
/// Example:
/// ```dart
/// TicketDivider.solid(
///   color: Colors.grey,
///   thickness: 1.0,
///   padding: 8.0,
/// )
/// ```
class SolidDividerStyle extends BaseDividerStyle {
  /// Creates a new [SolidDividerStyle].
  const SolidDividerStyle({super.color, super.thickness, super.padding});

  @override
  DividerStyle get style => DividerStyle.solid;
}

/// A dashed line divider style.
///
/// Properties:
/// - [dashWidth]: The width of each dash (default: 10.0)
/// - [dashSpace]: The space between dashes (default: 7.0)
///
/// Example:
/// ```dart
/// TicketDivider.dashed(
///   color: Colors.grey,
///   thickness: 1.0,
///   dashWidth: 10.0,
///   dashSpace: 7.0,
///   padding: 8.0,
/// )
/// ```
class DashedDividerStyle extends BaseDividerStyle {
  /// The width of each dash.
  final double dashWidth;

  /// The space between dashes.
  final double dashSpace;

  /// Creates a new [DashedDividerStyle].
  const DashedDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.dashWidth = 10.0,
    this.dashSpace = 7.0,
  });

  @override
  DividerStyle get style => DividerStyle.dashed;
}

/// A circles divider style.
///
/// Properties:
/// - [circleRadius]: The radius of each circle (default: 4.0)
/// - [circleSpacing]: The space between circles (default: 8.0)
///
/// Example:
/// ```dart
/// TicketDivider.circles(
///   color: Colors.grey,
///   thickness: 2.0,
///   circleRadius: 4.0,
///   circleSpacing: 8.0,
///   padding: 8.0,
/// )
/// ```
class CirclesDividerStyle extends BaseDividerStyle {
  /// The radius of each circle.
  final double circleRadius;

  /// The space between circles.
  final double circleSpacing;

  /// Creates a new [CirclesDividerStyle].
  const CirclesDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.circleRadius = 4.0,
    this.circleSpacing = 8.0,
  });

  @override
  DividerStyle get style => DividerStyle.circles;
}

/// A wave pattern divider style.
///
/// Properties:
/// - [waveHeight]: The height of each wave (default: 4.0)
/// - [waveWidth]: The width of each wave (default: 8.0)
///
/// Example:
/// ```dart
/// TicketDivider.wave(
///   color: Colors.grey,
///   thickness: 2.0,
///   waveHeight: 4.0,
///   waveWidth: 8.0,
///   padding: 8.0,
/// )
/// ```
class WaveDividerStyle extends BaseDividerStyle {
  /// The height of each wave.
  final double waveHeight;

  /// The width of each wave.
  final double waveWidth;

  /// Creates a new [WaveDividerStyle].
  const WaveDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.waveHeight = 4.0,
    this.waveWidth = 8.0,
  });

  @override
  DividerStyle get style => DividerStyle.wave;
}

/// A smooth wave pattern divider style.
///
/// Properties:
/// - [waveHeight]: The height of each wave (default: 4.0)
/// - [waveWidth]: The width of each wave (default: 8.0)
///
/// Example:
/// ```dart
/// TicketDivider.smoothWave(
///   color: Colors.grey,
///   thickness: 2.0,
///   waveHeight: 4.0,
///   waveWidth: 8.0,
///   padding: 8.0,
/// )
/// ```
class SmoothWaveDividerStyle extends BaseDividerStyle {
  /// The height of each wave.
  final double waveHeight;

  /// The width of each wave.
  final double waveWidth;

  /// Creates a new [SmoothWaveDividerStyle].
  const SmoothWaveDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.waveHeight = 4.0,
    this.waveWidth = 8.0,
  });

  @override
  DividerStyle get style => DividerStyle.smoothWave;
}

/// A dotted line divider style.
///
/// Properties:
/// - [dotSize]: The size of each dot (default: 4.0)
/// - [dotSpacing]: The space between dots (default: 8.0)
///
/// Example:
/// ```dart
/// TicketDivider.dotted(
///   color: Colors.grey,
///   thickness: 2.0,
///   dotSize: 2.0,
///   dotSpacing: 8.0,
///   padding: 8.0,
/// )
/// ```
class DottedDividerStyle extends BaseDividerStyle {
  /// The size of each dot.
  final double dotSize;

  /// The space between dots.
  final double dotSpacing;

  /// Creates a new [DottedDividerStyle].
  const DottedDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.dotSize = 4.0,
    this.dotSpacing = 8.0,
  });

  @override
  DividerStyle get style => DividerStyle.dotted;
}

/// A double line divider style.
///
/// Properties:
/// - [lineSpacing]: The space between the two lines (default: 4.0)
///
/// Example:
/// ```dart
/// TicketDivider.doubleLine(
///   color: Colors.grey,
///   thickness: 1.5,
///   lineSpacing: 4.0,
///   padding: 8.0,
/// )
/// ```
class DoubleLineDividerStyle extends BaseDividerStyle {
  /// The space between the two lines.
  final double lineSpacing;

  /// Creates a new [DoubleLineDividerStyle].
  const DoubleLineDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.lineSpacing = 4.0,
  });

  @override
  DividerStyle get style => DividerStyle.doubleLine;
}

/// A class that represents a divider between ticket sections.
///
/// This class provides factory constructors for creating different types of dividers
/// and methods for customizing their appearance. Each divider style has its own
/// set of properties that can be customized.
///
/// Example:
/// ```dart
/// // Create a solid divider
/// final solidDivider = TicketDivider.solid(
///   color: Colors.grey,
///   thickness: 1.0,
///   padding: 8.0,
/// );
///
/// // Create a dashed divider
/// final dashedDivider = TicketDivider.dashed(
///   color: Colors.grey,
///   thickness: 1.0,
///   dashWidth: 10.0,
///   dashSpace: 7.0,
///   padding: 8.0,
/// );
///
/// // Create a circles divider
/// final circlesDivider = TicketDivider.circles(
///   color: Colors.grey,
///   thickness: 2.0,
///   circleRadius: 4.0,
///   circleSpacing: 8.0,
///   padding: 8.0,
/// );
/// ```
class TicketDivider {
  final BaseDividerStyle _style;

  const TicketDivider._(this._style);

  /// The color of the divider.
  Color? get color => _style.color;

  /// The thickness of the divider.
  double? get thickness => _style.thickness;

  /// The style of the divider.
  DividerStyle get style => _style.style;

  /// The padding on both sides of the divider.
  double? get padding => _style.padding;

  // Style-specific getters
  /// The width of each dash in a dashed divider.
  double? get dashWidth =>
      _style is DashedDividerStyle ? (_style).dashWidth : null;

  /// The space between dashes in a dashed divider.
  double? get dashSpace =>
      _style is DashedDividerStyle ? (_style).dashSpace : null;

  /// The radius of each circle in a circles divider.
  double? get circleRadius =>
      _style is CirclesDividerStyle ? (_style).circleRadius : null;

  /// The space between circles in a circles divider.
  double? get circleSpacing =>
      _style is CirclesDividerStyle ? (_style).circleSpacing : null;

  /// The height of each wave in a wave or smooth wave divider.
  double? get waveHeight =>
      _style is WaveDividerStyle || _style is SmoothWaveDividerStyle
          ? (_style is WaveDividerStyle
              ? (_style).waveHeight
              : (_style as SmoothWaveDividerStyle).waveHeight)
          : null;

  /// The width of each wave in a wave or smooth wave divider.
  double? get waveWidth =>
      _style is WaveDividerStyle || _style is SmoothWaveDividerStyle
          ? (_style is WaveDividerStyle
              ? (_style).waveWidth
              : (_style as SmoothWaveDividerStyle).waveWidth)
          : null;

  /// The size of each dot in a dotted divider.
  double? get dotSize => _style is DottedDividerStyle ? (_style).dotSize : null;

  /// The space between dots in a dotted divider.
  double? get dotSpacing =>
      _style is DottedDividerStyle ? (_style).dotSpacing : null;

  /// The space between lines in a double line divider.
  double? get lineSpacing =>
      _style is DoubleLineDividerStyle ? (_style).lineSpacing : null;

  /// Creates a solid divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  factory TicketDivider.solid({
    Color? color,
    double? thickness,
    double? padding,
  }) {
    return TicketDivider._(
      SolidDividerStyle(color: color, thickness: thickness, padding: padding),
    );
  }

  /// Creates a dashed divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [dashWidth]: The width of each dash (default: 10.0)
  /// - [dashSpace]: The space between dashes (default: 7.0)
  factory TicketDivider.dashed({
    Color? color,
    double? thickness,
    double? padding,
    double dashWidth = 10.0,
    double dashSpace = 7.0,
  }) {
    return TicketDivider._(
      DashedDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
    );
  }

  /// Creates a circles divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [circleRadius]: The radius of each circle (default: 4.0)
  /// - [circleSpacing]: The space between circles (default: 8.0)
  factory TicketDivider.circles({
    Color? color,
    double? thickness,
    double? padding,
    double circleRadius = 4.0,
    double circleSpacing = 8.0,
  }) {
    return TicketDivider._(
      CirclesDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        circleRadius: circleRadius,
        circleSpacing: circleSpacing,
      ),
    );
  }

  /// Creates a wave divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [waveHeight]: The height of each wave (default: 4.0)
  /// - [waveWidth]: The width of each wave (default: 8.0)
  factory TicketDivider.wave({
    Color? color,
    double? thickness,
    double? padding,
    double waveHeight = 4.0,
    double waveWidth = 8.0,
  }) {
    return TicketDivider._(
      WaveDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        waveHeight: waveHeight,
        waveWidth: waveWidth,
      ),
    );
  }

  /// Creates a smooth wave divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [waveHeight]: The height of each wave (default: 4.0)
  /// - [waveWidth]: The width of each wave (default: 8.0)
  factory TicketDivider.smoothWave({
    Color? color,
    double? thickness,
    double? padding,
    double waveHeight = 4.0,
    double waveWidth = 8.0,
  }) {
    return TicketDivider._(
      SmoothWaveDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        waveHeight: waveHeight,
        waveWidth: waveWidth,
      ),
    );
  }

  /// Creates a dotted divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [dotSize]: The size of each dot (default: 4.0)
  /// - [dotSpacing]: The space between dots (default: 8.0)
  factory TicketDivider.dotted({
    Color? color,
    double? thickness,
    double? padding,
    double dotSize = 4.0,
    double dotSpacing = 8.0,
  }) {
    return TicketDivider._(
      DottedDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        dotSize: dotSize,
        dotSpacing: dotSpacing,
      ),
    );
  }

  /// Creates a double line divider.
  ///
  /// Parameters:
  /// - [color]: The color of the divider
  /// - [thickness]: The thickness of the divider
  /// - [padding]: The padding on both sides of the divider
  /// - [lineSpacing]: The space between the two lines (default: 4.0)
  factory TicketDivider.doubleLine({
    Color? color,
    double? thickness,
    double? padding,
    double lineSpacing = 4.0,
  }) {
    return TicketDivider._(
      DoubleLineDividerStyle(
        color: color,
        thickness: thickness,
        padding: padding,
        lineSpacing: lineSpacing,
      ),
    );
  }

  /// Creates a copy of this [TicketDivider] with the given fields replaced with the new values.
  ///
  /// This method allows you to create a new instance of [TicketDivider] with some
  /// properties changed while keeping others the same.
  ///
  /// Example:
  /// ```dart
  /// final divider = TicketDivider.solid(color: Colors.grey);
  /// final newDivider = divider.copyWith(color: Colors.blue);
  /// ```
  TicketDivider copyWith({
    Color? color,
    double? thickness,
    DividerStyle? style,
    double? padding,
    double? dashWidth,
    double? dashSpace,
    double? circleRadius,
    double? circleSpacing,
    double? waveHeight,
    double? waveWidth,
    double? dotSize,
    double? dotSpacing,
    double? lineSpacing,
  }) {
    if (style != null && style != this.style) {
      switch (style) {
        case DividerStyle.solid:
          return TicketDivider.solid(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
          );
        case DividerStyle.dashed:
          return TicketDivider.dashed(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            dashWidth: dashWidth ?? this.dashWidth ?? 10.0,
            dashSpace: dashSpace ?? this.dashSpace ?? 7.0,
          );
        case DividerStyle.circles:
          return TicketDivider.circles(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            circleRadius: circleRadius ?? this.circleRadius ?? 4.0,
            circleSpacing: circleSpacing ?? this.circleSpacing ?? 8.0,
          );
        case DividerStyle.wave:
          return TicketDivider.wave(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            waveHeight: waveHeight ?? this.waveHeight ?? 4.0,
            waveWidth: waveWidth ?? this.waveWidth ?? 8.0,
          );
        case DividerStyle.smoothWave:
          return TicketDivider.smoothWave(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            waveHeight: waveHeight ?? this.waveHeight ?? 4.0,
            waveWidth: waveWidth ?? this.waveWidth ?? 8.0,
          );
        case DividerStyle.dotted:
          return TicketDivider.dotted(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            dotSize: dotSize ?? this.dotSize ?? 4.0,
            dotSpacing: dotSpacing ?? this.dotSpacing ?? 8.0,
          );
        case DividerStyle.doubleLine:
          return TicketDivider.doubleLine(
            color: color ?? this.color,
            thickness: thickness ?? this.thickness,
            padding: padding ?? this.padding,
            lineSpacing: lineSpacing ?? this.lineSpacing ?? 4.0,
          );
      }
    }

    // If style hasn't changed, update the current style
    if (_style is SolidDividerStyle) {
      return TicketDivider.solid(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
      );
    } else if (_style is DashedDividerStyle) {
      return TicketDivider.dashed(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        dashWidth: dashWidth ?? this.dashWidth ?? 10.0,
        dashSpace: dashSpace ?? this.dashSpace ?? 7.0,
      );
    } else if (_style is CirclesDividerStyle) {
      return TicketDivider.circles(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        circleRadius: circleRadius ?? this.circleRadius ?? 4.0,
        circleSpacing: circleSpacing ?? this.circleSpacing ?? 8.0,
      );
    } else if (_style is WaveDividerStyle) {
      return TicketDivider.wave(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        waveHeight: waveHeight ?? this.waveHeight ?? 4.0,
        waveWidth: waveWidth ?? this.waveWidth ?? 8.0,
      );
    } else if (_style is SmoothWaveDividerStyle) {
      return TicketDivider.smoothWave(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        waveHeight: waveHeight ?? this.waveHeight ?? 4.0,
        waveWidth: waveWidth ?? this.waveWidth ?? 8.0,
      );
    } else if (_style is DottedDividerStyle) {
      return TicketDivider.dotted(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        dotSize: dotSize ?? this.dotSize ?? 4.0,
        dotSpacing: dotSpacing ?? this.dotSpacing ?? 8.0,
      );
    } else {
      return TicketDivider.doubleLine(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        padding: padding ?? this.padding,
        lineSpacing: lineSpacing ?? this.lineSpacing ?? 4.0,
      );
    }
  }
}
