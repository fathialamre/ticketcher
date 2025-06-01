import 'package:flutter/material.dart';

enum DividerStyle {
  solid,
  dashed,
  circles,
  wave,
  smoothWave,
  dotted,
  doubleLine,
}

abstract class BaseDividerStyle {
  final Color? color;
  final double? thickness;
  final double? padding;

  const BaseDividerStyle({this.color, this.thickness, this.padding});

  DividerStyle get style;
}

class SolidDividerStyle extends BaseDividerStyle {
  const SolidDividerStyle({super.color, super.thickness, super.padding});

  @override
  DividerStyle get style => DividerStyle.solid;
}

class DashedDividerStyle extends BaseDividerStyle {
  final double dashWidth;
  final double dashSpace;

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

class CirclesDividerStyle extends BaseDividerStyle {
  final double circleRadius;
  final double circleSpacing;

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

class WaveDividerStyle extends BaseDividerStyle {
  final double waveHeight;
  final double waveWidth;

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

class SmoothWaveDividerStyle extends BaseDividerStyle {
  final double waveHeight;
  final double waveWidth;

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

class DottedDividerStyle extends BaseDividerStyle {
  final double dotSize;
  final double dotSpacing;

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

class DoubleLineDividerStyle extends BaseDividerStyle {
  final double lineSpacing;

  const DoubleLineDividerStyle({
    super.color,
    super.thickness,
    super.padding,
    this.lineSpacing = 4.0,
  });

  @override
  DividerStyle get style => DividerStyle.doubleLine;
}

class TicketDivider {
  final BaseDividerStyle _style;

  const TicketDivider._(this._style);

  Color? get color => _style.color;
  double? get thickness => _style.thickness;
  DividerStyle get style => _style.style;
  double? get padding => _style.padding;

  // Style-specific getters
  double? get dashWidth =>
      _style is DashedDividerStyle ? (_style).dashWidth : null;
  double? get dashSpace =>
      _style is DashedDividerStyle ? (_style).dashSpace : null;
  double? get circleRadius =>
      _style is CirclesDividerStyle ? (_style).circleRadius : null;
  double? get circleSpacing =>
      _style is CirclesDividerStyle ? (_style).circleSpacing : null;
  double? get waveHeight =>
      _style is WaveDividerStyle || _style is SmoothWaveDividerStyle
          ? (_style is WaveDividerStyle
              ? (_style).waveHeight
              : (_style as SmoothWaveDividerStyle).waveHeight)
          : null;
  double? get waveWidth =>
      _style is WaveDividerStyle || _style is SmoothWaveDividerStyle
          ? (_style is WaveDividerStyle
              ? (_style).waveWidth
              : (_style as SmoothWaveDividerStyle).waveWidth)
          : null;
  double? get dotSize => _style is DottedDividerStyle ? (_style).dotSize : null;
  double? get dotSpacing =>
      _style is DottedDividerStyle ? (_style).dotSpacing : null;
  double? get lineSpacing =>
      _style is DoubleLineDividerStyle ? (_style).lineSpacing : null;

  // Factory constructors
  factory TicketDivider.solid({
    Color? color,
    double? thickness,
    double? padding,
  }) {
    return TicketDivider._(
      SolidDividerStyle(color: color, thickness: thickness, padding: padding),
    );
  }

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
