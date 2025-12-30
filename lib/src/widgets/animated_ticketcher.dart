import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/ticket_animation.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import 'vticketcher.dart';
import 'hticketcher.dart';

/// A widget that wraps a Ticketcher with animations.
///
/// This widget provides entry/exit animations for tickets.
/// It supports both vertical and horizontal orientations.
///
/// Example:
/// ```dart
/// AnimatedTicketcher(
///   animation: TicketAnimation.fadeIn(),
///   sections: [
///     Section(child: Text('Section 1')),
///     Section(child: Text('Section 2')),
///   ],
/// )
/// ```
class AnimatedTicketcher extends StatefulWidget {
  /// The animation configuration.
  final TicketAnimation animation;

  /// The list of sections to display.
  final List<Section> sections;

  /// The decoration for the ticket.
  final TicketcherDecoration decoration;

  /// The radius of the notches between sections.
  final double notchRadius;

  /// The width of the ticket (for vertical orientation).
  final double? width;

  /// The height of the ticket (for horizontal orientation).
  final double? height;

  /// Whether to use horizontal orientation.
  final bool isHorizontal;

  /// Optional back side content for flip animation.
  final Widget? backSide;

  /// Callback when flip animation completes (for flip animation).
  final VoidCallback? onFlipComplete;

  /// Controller for external animation control.
  final AnimatedTicketcherController? controller;

  /// Creates a new [AnimatedTicketcher] with vertical orientation.
  const AnimatedTicketcher({
    super.key,
    required this.animation,
    required this.sections,
    this.decoration = const TicketcherDecoration(),
    this.notchRadius = 10.0,
    this.width,
    this.backSide,
    this.onFlipComplete,
    this.controller,
  }) : isHorizontal = false,
       height = null;

  /// Creates a new [AnimatedTicketcher] with horizontal orientation.
  const AnimatedTicketcher.horizontal({
    super.key,
    required this.animation,
    required this.sections,
    this.decoration = const TicketcherDecoration(),
    this.notchRadius = 10.0,
    this.height,
    this.backSide,
    this.onFlipComplete,
    this.controller,
  }) : isHorizontal = true,
       width = null;

  @override
  State<AnimatedTicketcher> createState() => _AnimatedTicketcherState();
}

class _AnimatedTicketcherState extends State<AnimatedTicketcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _flipAnimation;

  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _setupController();
    _setupAnimations();

    // Connect external controller
    widget.controller?._state = this;

    // Auto-play if enabled
    if (widget.animation.autoPlay &&
        widget.animation.entryAnimation != AnimationType.none) {
      if (widget.animation.delay > Duration.zero) {
        Future.delayed(widget.animation.delay, () {
          if (mounted) _controller.forward();
        });
      } else {
        _controller.forward();
      }
    }
  }

  void _setupController() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animation.duration,
    );
  }

  void _setupAnimations() {
    final curve = CurvedAnimation(
      parent: _controller,
      curve: widget.animation.curve,
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    // Slide animations
    Offset slideBegin;
    switch (widget.animation.entryAnimation) {
      case AnimationType.slideUp:
        slideBegin = const Offset(0.0, 1.0);
        break;
      case AnimationType.slideDown:
        slideBegin = const Offset(0.0, -1.0);
        break;
      case AnimationType.slideLeft:
        slideBegin = const Offset(-1.0, 0.0);
        break;
      case AnimationType.slideRight:
        slideBegin = const Offset(1.0, 0.0);
        break;
      default:
        slideBegin = Offset.zero;
    }
    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(curve);

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    // Flip animation
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
  }

  @override
  void dispose() {
    widget.controller?._state = null;
    _controller.dispose();
    super.dispose();
  }

  /// Plays the entry animation.
  void playEntry() {
    _controller.forward(from: 0.0);
  }

  /// Plays the exit animation.
  void playExit() {
    _controller.reverse();
  }

  /// Flips the ticket (for double-sided tickets).
  void flip() {
    if (widget.animation.entryAnimation == AnimationType.flip) {
      _controller.forward(from: 0.0).then((_) {
        setState(() {
          _isFlipped = !_isFlipped;
        });
        widget.onFlipComplete?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget ticketWidget = _buildTicket();

    // Apply entry animation
    ticketWidget = _buildAnimatedWidget(ticketWidget);

    return ticketWidget;
  }

  Widget _buildTicket() {
    // For flip animation, show front or back
    if (widget.animation.entryAnimation == AnimationType.flip &&
        _isFlipped &&
        widget.backSide != null) {
      return widget.backSide!;
    }

    if (widget.isHorizontal) {
      return HTicketcher(
        sections: widget.sections,
        decoration: widget.decoration,
        notchRadius: widget.notchRadius,
        height: widget.height,
      );
    } else {
      return VTicketcher(
        sections: widget.sections,
        decoration: widget.decoration,
        notchRadius: widget.notchRadius,
        width: widget.width,
      );
    }
  }

  Widget _buildAnimatedWidget(Widget child) {
    switch (widget.animation.entryAnimation) {
      case AnimationType.none:
        return child;

      case AnimationType.fadeIn:
        return FadeTransition(opacity: _fadeAnimation, child: child);

      case AnimationType.slideUp:
      case AnimationType.slideDown:
      case AnimationType.slideLeft:
      case AnimationType.slideRight:
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(opacity: _fadeAnimation, child: child),
        );

      case AnimationType.scale:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(opacity: _fadeAnimation, child: child),
        );

      case AnimationType.flip:
        return AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, _) {
            final angle = _flipAnimation.value * math.pi;
            final transform =
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle);

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child:
                  _flipAnimation.value >= 0.5
                      ? Transform(
                        transform: Matrix4.identity()..rotateY(math.pi),
                        alignment: Alignment.center,
                        child: child,
                      )
                      : child,
            );
          },
        );
    }
  }
}

/// Controller for [AnimatedTicketcher].
///
/// Use this controller to programmatically control the animation.
class AnimatedTicketcherController {
  _AnimatedTicketcherState? _state;

  /// Plays the entry animation.
  void playEntry() {
    _state?.playEntry();
  }

  /// Plays the exit animation.
  void playExit() {
    _state?.playExit();
  }

  /// Flips the ticket (for double-sided tickets with flip animation).
  void flip() {
    _state?.flip();
  }

  /// Whether the controller is attached to a widget.
  bool get isAttached => _state != null;
}
