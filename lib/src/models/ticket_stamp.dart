import 'package:flutter/material.dart';

/// The outline drawn around a [TicketStamp].
enum StampShape {
  /// Sharp-cornered rectangle.
  rectangle,

  /// Rectangle with rounded corners.
  roundedRectangle,

  /// Circle sized to fit the text.
  circle,

  /// Ellipse sized to fit the text.
  oval,

  /// Circle with a scalloped (wavy) edge, like a wax or notary seal.
  seal,

  /// Six-sided badge with pointed left/right ends.
  hexagon,

  /// Ribbon with V-notched left/right ends.
  ribbon,
}

/// How the outline of a [TicketStamp] is stroked.
enum StampBorderStyle {
  /// One solid line.
  single,

  /// Two parallel lines (outer + inner).
  double,

  /// One dashed line.
  dashed,
}

/// A rubber-stamp mark drawn on top of the ticket — "USED", "VOID",
/// "PAID", "VIP", or any custom text — in one of several [StampShape]s.
///
/// Set on `TicketcherDecoration.stamp`. The stamp is a foreground layer:
/// it sits above the section content, is clipped to the ticket outline
/// (notches + corners), ignores pointer events, and stays in full color even
/// when `TicketcherDecoration.status` is [TicketStatus.expired].
///
/// Arabic and other RTL text is supported; letter spacing is disabled
/// automatically for Arabic script so letters stay joined.
///
/// Example:
/// ```dart
/// TicketcherDecoration(
///   stamp: TicketStamp.used(subtitle: '14 DEC 2026'),
/// )
///
/// TicketcherDecoration(
///   stamp: TicketStamp(
///     text: 'مُستخدَمة',
///     shape: StampShape.seal,
///     color: Colors.indigo,
///     rotation: 10,
///   ),
/// )
/// ```
@immutable
class TicketStamp {
  /// Main stamp text.
  final String text;

  /// Optional smaller second line under [text] (e.g. a date).
  final String? subtitle;

  /// Ink color for the outline and text.
  final Color color;

  /// Outline shape.
  final StampShape shape;

  /// Outline stroke style.
  final StampBorderStyle borderStyle;

  /// Outline stroke width in logical pixels. > 0.
  final double borderWidth;

  /// Clockwise rotation in degrees.
  final double rotation;

  /// Where the stamp sits within the ticket bounds.
  final Alignment alignment;

  /// Extra translation applied after [alignment].
  final Offset offset;

  /// Overall stamp opacity, 0.0–1.0.
  final double opacity;

  /// Space between the outline and the text.
  final EdgeInsets padding;

  /// Style for [text]. Color defaults to [color]; size defaults to 22.
  final TextStyle? textStyle;

  /// Style for [subtitle]. Color defaults to [color]; size defaults to 11.
  final TextStyle? subtitleStyle;

  /// Punches small random gaps through the ink for a worn rubber-stamp look.
  ///
  /// The pattern is deterministic for a given [inkSeed].
  final bool inkTexture;

  /// Seed for the [inkTexture] speckle pattern.
  final int inkSeed;

  /// Plays a short "thump" (scale-down + fade-in) the first time the stamp
  /// appears. Skipped when the platform requests reduced motion.
  final bool animateIn;

  /// Duration of the [animateIn] effect.
  final Duration animationDuration;

  const TicketStamp({
    required this.text,
    this.subtitle,
    this.color = const Color(0xFFB91C1C),
    this.shape = StampShape.roundedRectangle,
    this.borderStyle = StampBorderStyle.double,
    this.borderWidth = 3,
    this.rotation = -14,
    this.alignment = Alignment.center,
    this.offset = Offset.zero,
    this.opacity = 0.9,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.textStyle,
    this.subtitleStyle,
    this.inkTexture = true,
    this.inkSeed = 7,
    this.animateIn = false,
    this.animationDuration = const Duration(milliseconds: 360),
  })  : assert(borderWidth > 0 && borderWidth < double.infinity,
            'borderWidth must be a finite positive number'),
        assert(opacity >= 0.0 && opacity <= 1.0,
            'opacity must be between 0.0 and 1.0');

  /// Red double-bordered "USED" stamp.
  const TicketStamp.used({
    String text = 'USED',
    String? subtitle,
    Color color = const Color(0xFFB91C1C),
    double rotation = -14,
    Alignment alignment = Alignment.center,
    bool animateIn = false,
  }) : this(
          text: text,
          subtitle: subtitle,
          color: color,
          rotation: rotation,
          alignment: alignment,
          animateIn: animateIn,
        );

  /// Dark-red sharp rectangle "VOID" stamp.
  const TicketStamp.voided({
    String text = 'VOID',
    String? subtitle,
    Color color = const Color(0xFF7F1D1D),
    double rotation = -18,
    Alignment alignment = Alignment.center,
    bool animateIn = false,
  }) : this(
          text: text,
          subtitle: subtitle,
          color: color,
          shape: StampShape.rectangle,
          borderStyle: StampBorderStyle.single,
          borderWidth: 4,
          rotation: rotation,
          alignment: alignment,
          animateIn: animateIn,
        );

  /// Green circular "PAID" stamp.
  const TicketStamp.paid({
    String text = 'PAID',
    String? subtitle,
    Color color = const Color(0xFF15803D),
    double rotation = -10,
    Alignment alignment = Alignment.center,
    bool animateIn = false,
  }) : this(
          text: text,
          subtitle: subtitle,
          color: color,
          shape: StampShape.circle,
          rotation: rotation,
          alignment: alignment,
          animateIn: animateIn,
        );

  /// Gold scalloped-seal "VIP" stamp.
  const TicketStamp.vip({
    String text = 'VIP',
    String? subtitle,
    Color color = const Color(0xFFB45309),
    double rotation = 8,
    Alignment alignment = Alignment.center,
    bool animateIn = false,
  }) : this(
          text: text,
          subtitle: subtitle,
          color: color,
          shape: StampShape.seal,
          borderStyle: StampBorderStyle.single,
          rotation: rotation,
          alignment: alignment,
          animateIn: animateIn,
        );

  TicketStamp copyWith({
    String? text,
    String? subtitle,
    Color? color,
    StampShape? shape,
    StampBorderStyle? borderStyle,
    double? borderWidth,
    double? rotation,
    Alignment? alignment,
    Offset? offset,
    double? opacity,
    EdgeInsets? padding,
    TextStyle? textStyle,
    TextStyle? subtitleStyle,
    bool? inkTexture,
    int? inkSeed,
    bool? animateIn,
    Duration? animationDuration,
  }) {
    return TicketStamp(
      text: text ?? this.text,
      subtitle: subtitle ?? this.subtitle,
      color: color ?? this.color,
      shape: shape ?? this.shape,
      borderStyle: borderStyle ?? this.borderStyle,
      borderWidth: borderWidth ?? this.borderWidth,
      rotation: rotation ?? this.rotation,
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      opacity: opacity ?? this.opacity,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      inkTexture: inkTexture ?? this.inkTexture,
      inkSeed: inkSeed ?? this.inkSeed,
      animateIn: animateIn ?? this.animateIn,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketStamp &&
        other.text == text &&
        other.subtitle == subtitle &&
        other.color == color &&
        other.shape == shape &&
        other.borderStyle == borderStyle &&
        other.borderWidth == borderWidth &&
        other.rotation == rotation &&
        other.alignment == alignment &&
        other.offset == offset &&
        other.opacity == opacity &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.subtitleStyle == subtitleStyle &&
        other.inkTexture == inkTexture &&
        other.inkSeed == inkSeed &&
        other.animateIn == animateIn &&
        other.animationDuration == animationDuration;
  }

  @override
  int get hashCode => Object.hash(
        text,
        subtitle,
        color,
        shape,
        borderStyle,
        borderWidth,
        rotation,
        alignment,
        offset,
        opacity,
        padding,
        textStyle,
        subtitleStyle,
        inkTexture,
        inkSeed,
        animateIn,
        animationDuration,
      );
}

/// Lifecycle state of a ticket, set on `TicketcherDecoration.status`.
enum TicketStatus {
  /// Normal, full-color ticket.
  active,

  /// Greyed-out, dimmed ticket, reported as disabled to screen readers.
  /// A [TicketStamp] stays in full color on top.
  expired,
}
