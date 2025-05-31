import 'package:flutter/material.dart';

enum DividerStyle { solid, dashed }

class TicketDivider {
  final Color? color;
  final double? thickness;
  final DividerStyle style;
  final double? dashWidth;
  final double? dashSpace;

  const TicketDivider({
    this.color,
    this.thickness,
    this.style = DividerStyle.solid,
    this.dashWidth,
    this.dashSpace,
  });

  const TicketDivider.solid({this.color, this.thickness})
    : style = DividerStyle.solid,
      dashWidth = null,
      dashSpace = null;

  const TicketDivider.dashed({
    this.color,
    this.thickness,
    this.dashWidth = 10.0,
    this.dashSpace = 7.0,
  }) : style = DividerStyle.dashed;

  TicketDivider copyWith({
    Color? color,
    double? thickness,
    DividerStyle? style,
    double? dashWidth,
    double? dashSpace,
  }) {
    return TicketDivider(
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      style: style ?? this.style,
      dashWidth: dashWidth ?? this.dashWidth,
      dashSpace: dashSpace ?? this.dashSpace,
    );
  }
}
