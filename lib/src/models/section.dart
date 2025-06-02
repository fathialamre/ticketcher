import 'package:flutter/material.dart';

/// A widget that wraps its child with padding and optional width constraints.
///
/// Example:
/// ```dart
/// Section(
///   child: Text('Hello World'),
///   padding: EdgeInsets.all(16.0),
///   widthFactor: 0.8, // 80% of parent width
/// )
/// ```
///
/// The [child] parameter is required and specifies the widget to be wrapped.
/// The [padding] parameter defaults to EdgeInsets.all(1.0) and adds space around the child.
/// The [widthFactor] parameter is optional and constrains the width as a fraction of the parent width.

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
