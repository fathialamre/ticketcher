import 'package:flutter/material.dart';

/// Defines the available animation types for ticket entry/exit.
enum AnimationType {
  /// No animation.
  none,

  /// Fade in/out animation.
  fadeIn,

  /// Slide up animation.
  slideUp,

  /// Slide down animation.
  slideDown,

  /// Slide from left animation.
  slideLeft,

  /// Slide from right animation.
  slideRight,

  /// Scale/zoom animation.
  scale,

  /// 3D flip animation (for double-sided tickets).
  flip,
}

/// Configuration for ticket animations.
///
/// This class allows you to configure entry, exit, and special animations
/// for tickets.
///
/// Example:
/// ```dart
/// TicketAnimation.fadeIn(
///   duration: Duration(milliseconds: 500),
///   curve: Curves.easeOut,
/// )
/// ```
class TicketAnimation {
  /// The type of entry animation.
  final AnimationType entryAnimation;

  /// The type of exit animation.
  final AnimationType exitAnimation;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// Whether to auto-play entry animation on build.
  final bool autoPlay;

  /// Delay before starting the animation.
  final Duration delay;

  /// Creates a new [TicketAnimation].
  const TicketAnimation({
    this.entryAnimation = AnimationType.none,
    this.exitAnimation = AnimationType.none,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
    this.delay = Duration.zero,
  });

  /// Creates a fade in animation.
  factory TicketAnimation.fadeIn({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.fadeIn,
      exitAnimation: AnimationType.fadeIn,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a slide up animation.
  factory TicketAnimation.slideUp({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.slideUp,
      exitAnimation: AnimationType.slideDown,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a slide down animation.
  factory TicketAnimation.slideDown({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.slideDown,
      exitAnimation: AnimationType.slideUp,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a slide from left animation.
  factory TicketAnimation.slideLeft({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.slideLeft,
      exitAnimation: AnimationType.slideRight,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a slide from right animation.
  factory TicketAnimation.slideRight({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.slideRight,
      exitAnimation: AnimationType.slideLeft,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a scale animation.
  factory TicketAnimation.scale({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutBack,
    Duration delay = Duration.zero,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.scale,
      exitAnimation: AnimationType.scale,
      duration: duration,
      curve: curve,
      delay: delay,
    );
  }

  /// Creates a flip animation for double-sided tickets.
  factory TicketAnimation.flip({
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOut,
  }) {
    return TicketAnimation(
      entryAnimation: AnimationType.flip,
      exitAnimation: AnimationType.flip,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a copy of this [TicketAnimation] with the given fields replaced.
  TicketAnimation copyWith({
    AnimationType? entryAnimation,
    AnimationType? exitAnimation,
    Duration? duration,
    Curve? curve,
    bool? autoPlay,
    Duration? delay,
  }) {
    return TicketAnimation(
      entryAnimation: entryAnimation ?? this.entryAnimation,
      exitAnimation: exitAnimation ?? this.exitAnimation,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      autoPlay: autoPlay ?? this.autoPlay,
      delay: delay ?? this.delay,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketAnimation &&
        other.entryAnimation == entryAnimation &&
        other.exitAnimation == exitAnimation &&
        other.duration == duration &&
        other.curve == curve &&
        other.autoPlay == autoPlay &&
        other.delay == delay;
  }

  @override
  int get hashCode => Object.hash(
    entryAnimation,
    exitAnimation,
    duration,
    curve,
    autoPlay,
    delay,
  );
}
