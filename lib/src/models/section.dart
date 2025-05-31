import 'package:flutter/material.dart';

class Section {
  final Widget child;
  final EdgeInsets padding;

  const Section({
    required this.child,
    this.padding = const EdgeInsets.all(1.0),
  });

  Section copyWith({Widget? child, EdgeInsets? padding}) {
    return Section(
      child: child ?? this.child,
      padding: padding ?? this.padding,
    );
  }
}
