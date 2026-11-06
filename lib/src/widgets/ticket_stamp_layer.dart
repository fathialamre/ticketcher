import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/ticket_stamp.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/stamp_painter.dart';

/// Greyscale matrix (Rec. 709 luma) applied to expired tickets.
const ColorFilter _greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0, 0, 0, 1, 0,
]);

/// Applies `decoration.status` to [ticket] and lays `decoration.stamp` over
/// it, clipped by [clipper] to the ticket outline. Returns [ticket] unchanged
/// when the ticket is active and has no stamp.
///
/// The stamp sits outside the status filter so it stays in full color on an
/// expired ticket.
Widget wrapTicketStatusAndStamp({
  required Widget ticket,
  required TicketcherDecoration decoration,
  required CustomClipper<Path> clipper,
}) {
  Widget result = ticket;

  if (decoration.status == TicketStatus.expired) {
    result = Semantics(
      enabled: false,
      child: Opacity(
        opacity: 0.55,
        child: ColorFiltered(colorFilter: _greyscale, child: result),
      ),
    );
  }

  final stamp = decoration.stamp;
  if (stamp == null) {
    return result;
  }

  Widget mark = TicketStampMark(stamp: stamp);
  if (stamp.rotation != 0) {
    mark = Transform.rotate(angle: stamp.rotation * math.pi / 180, child: mark);
  }
  if (stamp.offset != Offset.zero) {
    mark = Transform.translate(offset: stamp.offset, child: mark);
  }

  return Stack(
    children: [
      result,
      Positioned.fill(
        child: IgnorePointer(
          child: ClipPath(
            clipper: clipper,
            child: Align(alignment: stamp.alignment, child: mark),
          ),
        ),
      ),
    ],
  );
}

/// A standalone [TicketStamp] mark at its natural size, unrotated.
///
/// Tickets draw this automatically for `TicketcherDecoration.stamp`; use it
/// directly to place a stamp anywhere else (lists, dialogs, previews).
/// Plays the [TicketStamp.animateIn] effect on first build unless the
/// platform requests reduced motion.
class TicketStampMark extends StatefulWidget {
  /// The stamp to draw.
  final TicketStamp stamp;

  const TicketStampMark({super.key, required this.stamp});

  @override
  State<TicketStampMark> createState() => _TicketStampMarkState();
}

class _TicketStampMarkState extends State<TicketStampMark>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scale;
  Animation<double>? _fade;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (widget.stamp.animateIn && !reduceMotion) {
      final controller = AnimationController(
        vsync: this,
        duration: widget.stamp.animationDuration,
      );
      _controller = controller;
      _scale = Tween<double>(begin: 1.6, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
      _fade = CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      );
      controller.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stamp = widget.stamp;
    final textDirection =
        Directionality.maybeOf(context) ?? TextDirection.ltr;
    final textScaler =
        MediaQuery.maybeTextScalerOf(context) ?? TextScaler.noScaling;

    final size = TicketStampPainter.measure(
      stamp,
      textDirection: textDirection,
      textScaler: textScaler,
    );

    Widget mark = Opacity(
      opacity: stamp.opacity,
      child: CustomPaint(
        size: size,
        painter: TicketStampPainter(
          stamp: stamp,
          textDirection: textDirection,
          textScaler: textScaler,
        ),
      ),
    );

    final scale = _scale;
    final fade = _fade;
    if (scale != null && fade != null) {
      mark = FadeTransition(
        opacity: fade,
        child: ScaleTransition(scale: scale, child: mark),
      );
    }

    final label = stamp.subtitle == null
        ? stamp.text
        : '${stamp.text}, ${stamp.subtitle}';
    return Semantics(label: label, container: true, child: mark);
  }
}
