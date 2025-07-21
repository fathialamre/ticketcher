import 'package:flutter/material.dart';

/// Defines the alignment of the watermark within the ticket
enum WatermarkAlignment {
  /// Top left corner
  topLeft,

  /// Top center
  topCenter,

  /// Top right corner
  topRight,

  /// Center left
  centerLeft,

  /// Center of the ticket
  center,

  /// Center right
  centerRight,

  /// Bottom left corner
  bottomLeft,

  /// Bottom center
  bottomCenter,

  /// Bottom right corner
  bottomRight,
}

/// Defines the type of watermark to display
enum WatermarkType {
  /// Text-based watermark
  text,

  /// Widget-based watermark
  widget,
}

/// A class that defines a watermark for a ticket.
///
/// Watermarks can be used for branding, security, or decorative purposes.
/// They support both text and image content with various positioning and styling options.
///
/// Example text watermark:
/// ```dart
/// TicketWatermark.text(
///   text: 'CONFIDENTIAL',
///   opacity: 0.3,
///   alignment: WatermarkAlignment.center,
///   rotation: 45,
///   style: TextStyle(
///     fontSize: 24,
///     fontWeight: FontWeight.bold,
///     color: Colors.red,
///   ),
/// )
/// ```
///
/// Example widget watermark:
/// ```dart
/// TicketWatermark.widget(
///   widget: Icon(Icons.verified, size: 80, color: Colors.blue),
///   opacity: 0.2,
///   alignment: WatermarkAlignment.bottomRight,
/// )
/// ```
class TicketWatermark {
  /// The type of watermark (text or image)
  final WatermarkType type;

  /// The text content for text watermarks
  final String? text;

  /// The text style for text watermarks
  final TextStyle? textStyle;

  /// The widget for widget watermarks
  final Widget? widget;

  /// The width of the watermark (applies to widgets)
  final double? width;

  /// The height of the watermark (applies to widgets)
  final double? height;

  /// The opacity of the watermark (0.0 to 1.0)
  final double opacity;

  /// The alignment of the watermark within the ticket
  final WatermarkAlignment alignment;

  /// The rotation angle in degrees (0-360)
  final double rotation;

  /// Custom offset from the aligned position
  final Offset offset;

  /// Whether the watermark should repeat across the ticket
  final bool repeat;

  /// The spacing between repeated watermarks (only when repeat is true)
  final double repeatSpacing;

  /// Creates a watermark with the specified properties
  const TicketWatermark({
    required this.type,
    this.text,
    this.textStyle,
    this.widget,
    this.width,
    this.height,
    this.opacity = 0.3,
    this.alignment = WatermarkAlignment.center,
    this.rotation = 0.0,
    this.offset = Offset.zero,
    this.repeat = false,
    this.repeatSpacing = 50.0,
  }) : assert(
         (type == WatermarkType.text && text != null) ||
             (type == WatermarkType.widget && widget != null),
         'Text watermarks must have text, widget watermarks must have a widget',
       ),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'Opacity must be between 0.0 and 1.0',
       ),
       assert(
         rotation >= 0.0 && rotation <= 360.0,
         'Rotation must be between 0.0 and 360.0 degrees',
       );

  /// Creates a text-based watermark
  const TicketWatermark.text({
    required String text,
    TextStyle? style,
    double opacity = 0.3,
    WatermarkAlignment alignment = WatermarkAlignment.center,
    double rotation = 0.0,
    Offset offset = Offset.zero,
    bool repeat = false,
    double repeatSpacing = 50.0,
  }) : this(
         type: WatermarkType.text,
         text: text,
         textStyle: style,
         opacity: opacity,
         alignment: alignment,
         rotation: rotation,
         offset: offset,
         repeat: repeat,
         repeatSpacing: repeatSpacing,
       );

  /// Creates a widget-based watermark
  ///
  /// Note: Widget watermarks do not support repeat functionality for performance reasons.
  /// Use text watermarks if you need repeating patterns.
  const TicketWatermark.widget({
    required Widget widget,
    double? width,
    double? height,
    double opacity = 0.3,
    WatermarkAlignment alignment = WatermarkAlignment.center,
    double rotation = 0.0,
    Offset offset = Offset.zero,
  }) : this(
         type: WatermarkType.widget,
         widget: widget,
         width: width,
         height: height,
         opacity: opacity,
         alignment: alignment,
         rotation: rotation,
         offset: offset,
         repeat: false, // Widget watermarks don't support repeat
         repeatSpacing: 50.0,
       );

  /// Creates a copy of this watermark with the given fields replaced
  TicketWatermark copyWith({
    WatermarkType? type,
    String? text,
    TextStyle? textStyle,
    Widget? widget,
    double? width,
    double? height,
    double? opacity,
    WatermarkAlignment? alignment,
    double? rotation,
    Offset? offset,
    bool? repeat,
    double? repeatSpacing,
  }) {
    return TicketWatermark(
      type: type ?? this.type,
      text: text ?? this.text,
      textStyle: textStyle ?? this.textStyle,
      widget: widget ?? this.widget,
      width: width ?? this.width,
      height: height ?? this.height,
      opacity: opacity ?? this.opacity,
      alignment: alignment ?? this.alignment,
      rotation: rotation ?? this.rotation,
      offset: offset ?? this.offset,
      repeat: repeat ?? this.repeat,
      repeatSpacing: repeatSpacing ?? this.repeatSpacing,
    );
  }

  /// Gets the alignment as a Flutter Alignment object
  Alignment get flutterAlignment {
    switch (alignment) {
      case WatermarkAlignment.topLeft:
        return Alignment.topLeft;
      case WatermarkAlignment.topCenter:
        return Alignment.topCenter;
      case WatermarkAlignment.topRight:
        return Alignment.topRight;
      case WatermarkAlignment.centerLeft:
        return Alignment.centerLeft;
      case WatermarkAlignment.center:
        return Alignment.center;
      case WatermarkAlignment.centerRight:
        return Alignment.centerRight;
      case WatermarkAlignment.bottomLeft:
        return Alignment.bottomLeft;
      case WatermarkAlignment.bottomCenter:
        return Alignment.bottomCenter;
      case WatermarkAlignment.bottomRight:
        return Alignment.bottomRight;
    }
  }
}
