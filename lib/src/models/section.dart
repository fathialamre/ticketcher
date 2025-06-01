import 'package:flutter/material.dart';

class Section {
  final Widget child;
  final EdgeInsets padding;
  final double? widthFactor;

  const Section({
    required this.child,
    this.padding = const EdgeInsets.all(1.0),
    this.widthFactor,
  });

  Section copyWith({Widget? child, EdgeInsets? padding, double? widthFactor}) {
    return Section(
      child: child ?? this.child,
      padding: padding ?? this.padding,
      widthFactor: widthFactor ?? this.widthFactor,
    );
  }
}
