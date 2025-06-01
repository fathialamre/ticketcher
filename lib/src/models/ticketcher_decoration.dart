import 'package:flutter/material.dart';
import 'border_pattern.dart';
import 'ticket_divider.dart';
import 'ticket_radius.dart';

class TicketcherDecoration {
  final TicketRadius borderRadius;
  final Border? border;
  final Color backgroundColor;
  final Gradient? gradient;
  final TicketDivider? divider;
  final BorderPattern? bottomBorderStyle;
  final BorderPattern? leftBorderStyle;
  final BorderPattern? rightBorderStyle;
  final BoxShadow? shadow;

  const TicketcherDecoration({
    this.borderRadius = const TicketRadius(radius: 8.0),
    this.border,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.divider,
    this.bottomBorderStyle,
    this.leftBorderStyle,
    this.rightBorderStyle,
    this.shadow,
  });

  TicketcherDecoration copyWith({
    TicketRadius? borderRadius,
    Border? border,
    Color? backgroundColor,
    Gradient? gradient,
    TicketDivider? divider,
    BorderPattern? bottomBorderStyle,
    BorderPattern? leftBorderStyle,
    BorderPattern? rightBorderStyle,
    BoxShadow? shadow,
  }) {
    return TicketcherDecoration(
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      divider: divider ?? this.divider,
      bottomBorderStyle: bottomBorderStyle ?? this.bottomBorderStyle,
      leftBorderStyle: leftBorderStyle ?? this.leftBorderStyle,
      rightBorderStyle: rightBorderStyle ?? this.rightBorderStyle,
      shadow: shadow ?? this.shadow,
    );
  }
}
