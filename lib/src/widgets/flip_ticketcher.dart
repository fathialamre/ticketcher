import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Which gestures flip a [FlipTicketcher].
enum FlipTrigger {
  /// A tap flips it.
  tap,

  /// A drag along the flip direction flips it, following the finger.
  swipe,

  /// Either a tap or a drag.
  tapOrSwipe,

  /// No gestures; flip only through a [FlipTicketcherController].
  none,
}

/// Drives a [FlipTicketcher] programmatically.
///
/// Attach it by passing it to one [FlipTicketcher] at a time.
///
/// ```dart
/// final flip = FlipTicketcherController();
/// // ...
/// FlipTicketcher(controller: flip, front: ..., back: ...);
/// // ...
/// await flip.flip();
/// ```
class FlipTicketcherController {
  _FlipTicketcherState? _state;

  /// Whether a [FlipTicketcher] is currently using this controller.
  bool get isAttached => _state != null;

  /// Whether the front face is showing (or is the face being flipped to).
  /// `true` when detached.
  bool get isFront => _state?._isFront ?? true;

  /// Flips to the other face. Completes when the animation ends.
  Future<void> flip() => _state?._animateTo(back: _state!._isFront) ??
      Future<void>.value();

  /// Flips to the front face if not already there.
  Future<void> showFront() =>
      _state?._animateTo(back: false) ?? Future<void>.value();

  /// Flips to the back face if not already there.
  Future<void> showBack() =>
      _state?._animateTo(back: true) ?? Future<void>.value();
}

/// A two-sided ticket that flips in 3D between a [front] and a [back].
///
/// Typically both faces are tickets ([Ticketcher], [VTicketcher],
/// [HTicketcher]) — details on the front, a QR code and terms on the back —
/// but any widgets work. The widget takes the size of the larger face, so
/// give both faces the same size for a clean flip.
///
/// Flip by tap and/or drag ([trigger]) or with a [controller]. When the
/// platform requests reduced motion the faces swap without animating.
///
/// ```dart
/// FlipTicketcher(
///   trigger: FlipTrigger.tapOrSwipe,
///   front: Ticketcher.vertical(sections: frontSections),
///   back: Ticketcher.vertical(sections: backSections),
///   onFlip: (isFront) => debugPrint('front: $isFront'),
/// )
/// ```
class FlipTicketcher extends StatefulWidget {
  /// Face shown initially (unless [initiallyShowBack]).
  final Widget front;

  /// Face revealed by flipping.
  final Widget back;

  /// Optional controller for flipping from code.
  final FlipTicketcherController? controller;

  /// Gestures that flip the ticket. Defaults to [FlipTrigger.tap].
  final FlipTrigger trigger;

  /// Flip direction. [Axis.horizontal] turns the ticket left/right (around
  /// its vertical axis); [Axis.vertical] turns it top/bottom.
  final Axis axis;

  /// Duration of a full flip.
  final Duration duration;

  /// Easing for tap and controller flips.
  final Curve curve;

  /// Start on the [back] face.
  final bool initiallyShowBack;

  /// Depth of the 3D perspective. 0 is flat; larger is more dramatic.
  final double perspective;

  /// Called with `true` when the front face settles, `false` for the back.
  final ValueChanged<bool>? onFlip;

  const FlipTicketcher({
    super.key,
    required this.front,
    required this.back,
    this.controller,
    this.trigger = FlipTrigger.tap,
    this.axis = Axis.horizontal,
    this.duration = const Duration(milliseconds: 450),
    this.curve = Curves.easeInOut,
    this.initiallyShowBack = false,
    this.perspective = 0.0015,
    this.onFlip,
  });

  @override
  State<FlipTicketcher> createState() => _FlipTicketcherState();
}

class _FlipTicketcherState extends State<FlipTicketcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Face the ticket is showing or flipping to.
  late bool _showingBack;

  /// Face last reported through [FlipTicketcher.onFlip].
  late bool _settledBack;

  double _dragDistance = 0;

  bool get _isFront => !_showingBack;

  bool get _tapEnabled =>
      widget.trigger == FlipTrigger.tap ||
      widget.trigger == FlipTrigger.tapOrSwipe;

  bool get _swipeEnabled =>
      widget.trigger == FlipTrigger.swipe ||
      widget.trigger == FlipTrigger.tapOrSwipe;

  @override
  void initState() {
    super.initState();
    _showingBack = widget.initiallyShowBack;
    _settledBack = _showingBack;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: _showingBack ? 1 : 0,
    );
    widget.controller?._state = this;
  }

  @override
  void didUpdateWidget(FlipTicketcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller?._state == this) {
        oldWidget.controller!._state = null;
      }
      widget.controller?._state = this;
    }
    _controller.duration = widget.duration;
  }

  @override
  void dispose() {
    if (widget.controller?._state == this) {
      widget.controller!._state = null;
    }
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateTo({required bool back, Curve? curve}) async {
    _showingBack = back;
    final target = back ? 1.0 : 0.0;

    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduceMotion) {
      _controller.value = target;
    } else if (_controller.value != target) {
      final done = Completer<void>();
      _controller
          .animateTo(target, curve: curve ?? widget.curve)
          .whenCompleteOrCancel(done.complete);
      await done.future;
    }

    // A newer flip may have started while this one ran.
    if (!mounted || _showingBack != back || _controller.value != target) {
      return;
    }
    if (_settledBack != back) {
      _settledBack = back;
      widget.onFlip?.call(!back);
    }
  }

  double get _dragExtent {
    final size = context.size;
    if (size == null) return 1;
    final extent =
        widget.axis == Axis.horizontal ? size.width : size.height;
    return extent > 0 ? extent : 1;
  }

  void _onDragStart(DragStartDetails details) {
    _controller.stop();
    _dragDistance = 0;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragDistance += details.primaryDelta ?? 0;
    final progress = (_dragDistance.abs() / _dragExtent).clamp(0.0, 1.0);
    _controller.value = _showingBack ? 1 - progress : progress;
  }

  void _onDragEnd(DragEndDetails details) {
    final progress = (_dragDistance.abs() / _dragExtent).clamp(0.0, 1.0);
    final velocity = details.primaryVelocity ?? 0;
    final flips = progress > 0.5 || velocity.abs() > 700;
    _animateTo(
      back: flips ? !_showingBack : _showingBack,
      curve: Curves.easeOut,
    );
  }

  Matrix4 _transformFor(double angle) {
    final matrix = Matrix4.identity()..setEntry(3, 2, widget.perspective);
    return widget.axis == Axis.horizontal
        ? (matrix..rotateY(angle))
        : (matrix..rotateX(angle));
  }

  @override
  Widget build(BuildContext context) {
    // The back face is pre-rotated half a turn so it reads correctly once
    // the whole card has turned past 90°.
    final back = Transform(
      alignment: Alignment.center,
      transform: widget.axis == Axis.horizontal
          ? Matrix4.rotationY(math.pi)
          : Matrix4.rotationX(math.pi),
      child: widget.back,
    );

    Widget card = AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final angle = _controller.value * math.pi;
        final frontVisible = angle <= math.pi / 2;
        return Transform(
          alignment: Alignment.center,
          transform: _transformFor(angle),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: frontVisible,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: widget.front,
              ),
              Visibility(
                visible: !frontVisible,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: back,
              ),
            ],
          ),
        );
      },
    );

    if (_tapEnabled || _swipeEnabled) {
      final horizontal = widget.axis == Axis.horizontal;
      card = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _tapEnabled ? () => _animateTo(back: _isFront) : null,
        onHorizontalDragStart:
            _swipeEnabled && horizontal ? _onDragStart : null,
        onHorizontalDragUpdate:
            _swipeEnabled && horizontal ? _onDragUpdate : null,
        onHorizontalDragEnd: _swipeEnabled && horizontal ? _onDragEnd : null,
        onVerticalDragStart:
            _swipeEnabled && !horizontal ? _onDragStart : null,
        onVerticalDragUpdate:
            _swipeEnabled && !horizontal ? _onDragUpdate : null,
        onVerticalDragEnd: _swipeEnabled && !horizontal ? _onDragEnd : null,
        child: card,
      );
    }

    return Semantics(button: _tapEnabled, child: card);
  }
}
