import 'package:flutter/material.dart';

enum DividerStyle { solid, dashed, circles, wave, smoothWave }

class TicketDivider {
  final Color? color;
  final double? thickness;
  final DividerStyle style;
  final double? dashWidth;
  final double? dashSpace;
  final double? circleRadius;
  final double? circleSpacing;
  final double? waveHeight;
  final double? waveWidth;

  const TicketDivider({
    this.color,
    this.thickness,
    this.style = DividerStyle.solid,
    this.dashWidth,
    this.dashSpace,
    this.circleRadius,
    this.circleSpacing,
    this.waveHeight,
    this.waveWidth,
  });

  const TicketDivider.solid({this.color, this.thickness})
    : style = DividerStyle.solid,
      dashWidth = null,
      dashSpace = null,
      circleRadius = null,
      circleSpacing = null,
      waveHeight = null,
      waveWidth = null;

  const TicketDivider.dashed({
    this.color,
    this.thickness,
    this.dashWidth = 10.0,
    this.dashSpace = 7.0,
  }) : style = DividerStyle.dashed,
       circleRadius = null,
       circleSpacing = null,
       waveHeight = null,
       waveWidth = null;

  const TicketDivider.circles({
    this.color,
    this.thickness,
    this.circleRadius = 4.0,
    this.circleSpacing = 8.0,
  }) : style = DividerStyle.circles,
       dashWidth = null,
       dashSpace = null,
       waveHeight = null,
       waveWidth = null;

  const TicketDivider.wave({
    this.color,
    this.thickness,
    this.waveHeight = 4.0,
    this.waveWidth = 8.0,
  }) : style = DividerStyle.wave,
       dashWidth = null,
       dashSpace = null,
       circleRadius = null,
       circleSpacing = null;

  const TicketDivider.smoothWave({
    this.color,
    this.thickness,
    this.waveHeight = 4.0,
    this.waveWidth = 8.0,
  }) : style = DividerStyle.smoothWave,
       dashWidth = null,
       dashSpace = null,
       circleRadius = null,
       circleSpacing = null;

  TicketDivider copyWith({
    Color? color,
    double? thickness,
    DividerStyle? style,
    double? dashWidth,
    double? dashSpace,
    double? circleRadius,
    double? circleSpacing,
    double? waveHeight,
    double? waveWidth,
  }) {
    return TicketDivider(
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      style: style ?? this.style,
      dashWidth: dashWidth ?? this.dashWidth,
      dashSpace: dashSpace ?? this.dashSpace,
      circleRadius: circleRadius ?? this.circleRadius,
      circleSpacing: circleSpacing ?? this.circleSpacing,
      waveHeight: waveHeight ?? this.waveHeight,
      waveWidth: waveWidth ?? this.waveWidth,
    );
  }
}
