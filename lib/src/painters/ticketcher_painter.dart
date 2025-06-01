import 'package:flutter/material.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../models/border_pattern.dart';
import '../models/ticket_divider.dart';

class TicketcherPainter extends CustomPainter {
  final double notchRadius;
  final List<double> sectionHeights;
  final TicketcherDecoration decoration;

  TicketcherPainter({
    required this.notchRadius,
    required this.sectionHeights,
    required this.decoration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final radius = decoration.borderRadius.radius;
    final direction = decoration.borderRadius.direction;
    final corner = decoration.borderRadius.corner;

    // Helper function to determine if a corner should be rounded
    bool shouldRoundCorner(TicketCorner targetCorner) {
      switch (corner) {
        case TicketCorner.all:
          return true;
        case TicketCorner.top:
          return targetCorner == TicketCorner.topLeft ||
              targetCorner == TicketCorner.topRight;
        case TicketCorner.bottom:
          return targetCorner == TicketCorner.bottomLeft ||
              targetCorner == TicketCorner.bottomRight;
        case TicketCorner.none:
          return false;
        default:
          return corner == targetCorner;
      }
    }

    // Start from the top-left corner
    if (shouldRoundCorner(TicketCorner.topLeft)) {
      path.moveTo(radius, 0);
    } else {
      path.moveTo(0, 0);
    }

    // Top edge and top-right corner
    if (shouldRoundCorner(TicketCorner.topRight)) {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    } else {
      path.lineTo(size.width, 0);
    }

    // Calculate cumulative heights for each section
    List<double> cumulativeHeights = [];
    double currentHeight = 0;
    for (double height in sectionHeights) {
      currentHeight += height;
      cumulativeHeights.add(currentHeight);
    }

    // Draw right edge with notches
    for (int i = 0; i < sectionHeights.length - 1; i++) {
      final notchY = cumulativeHeights[i];

      // Line to notch
      path.lineTo(size.width, notchY - notchRadius);

      // Right notch
      path.arcToPoint(
        Offset(size.width, notchY + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // Right edge to bottom
    path.lineTo(
      size.width,
      size.height - (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0),
    );

    // Bottom-right corner
    if (shouldRoundCorner(TicketCorner.bottomRight)) {
      path.arcToPoint(
        Offset(size.width - radius, size.height),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Bottom edge with optional pattern
    if (decoration.bottomBorderStyle != null) {
      final style = decoration.bottomBorderStyle!;
      final availableWidth =
          size.width -
          (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0) -
          (shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0);

      // For arc pattern, we need to calculate the number of complete segments
      if (style.shape == BorderShape.arc) {
        // Calculate the total number of elements (arcs + gaps)
        // We want to start and end with gaps, so we need one more gap than arcs
        final arcWidth = style.height * 2; // Full arc width
        final gapWidth = style.height; // Base gap width

        // Calculate how many complete arcs we can fit
        final numArcs =
            ((availableWidth - gapWidth) / (arcWidth + gapWidth)).floor();

        // Calculate the total width needed for the pattern
        final totalPatternWidth = (numArcs * (arcWidth + gapWidth)) + gapWidth;

        // Calculate the extra space to distribute
        final extraSpace = availableWidth - totalPatternWidth;
        final extraGapWidth = extraSpace / (numArcs + 1);

        // Start from the right edge
        var currentX = size.width;
        final endX = 0.0;

        // Draw the initial gap
        path.lineTo(currentX - (gapWidth + extraGapWidth), size.height);
        currentX -= (gapWidth + extraGapWidth);

        // Draw segments from right to left
        for (int i = 0; i < numArcs; i++) {
          // Draw the full arc
          path.arcToPoint(
            Offset(currentX - arcWidth, size.height),
            radius: Radius.circular(style.height),
            clockwise: false,
          );
          currentX -= arcWidth;

          // Draw the gap (including extra distributed space)
          if (i < numArcs - 1) {
            path.lineTo(currentX - (gapWidth + extraGapWidth), size.height);
            currentX -= (gapWidth + extraGapWidth);
          }
        }

        // Draw the final gap if needed
        if (currentX > endX) {
          path.lineTo(endX, size.height);
        }
      } else {
        // Original implementation for other patterns
        final numSegments = (availableWidth / style.width).floor();
        final adjustedWidth = availableWidth / numSegments;
        var currentX = size.width;
        final endX = 0.0;

        while (currentX > endX) {
          final nextX = (currentX - adjustedWidth).clamp(endX, size.width);
          final midX = (currentX + nextX) / 2;

          switch (style.shape) {
            case BorderShape.wave:
              path.quadraticBezierTo(
                midX,
                size.height + style.height,
                nextX,
                size.height,
              );
              break;
            case BorderShape.sharp:
              path.lineTo(midX, size.height + style.height);
              path.lineTo(nextX, size.height);
              break;
            case BorderShape.arc:
              // This case is handled above
              break;
          }
          currentX = nextX;
        }
      }
    } else {
      // Regular straight bottom edge
      path.lineTo(
        shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0,
        size.height,
      );
    }

    // Bottom-left corner
    if (shouldRoundCorner(TicketCorner.bottomLeft)) {
      path.arcToPoint(
        Offset(0, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Draw left edge with notches
    for (int i = sectionHeights.length - 2; i >= 0; i--) {
      final notchY = cumulativeHeights[i];

      // Line to notch
      path.lineTo(0, notchY + notchRadius);

      // Left notch
      path.arcToPoint(
        Offset(0, notchY - notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // Left edge to top-left corner
    path.lineTo(0, shouldRoundCorner(TicketCorner.topLeft) ? radius : 0);

    // Top-left corner
    if (shouldRoundCorner(TicketCorner.topLeft)) {
      path.arcToPoint(
        Offset(radius, 0),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Close the path to ensure a smooth connection
    path.close();

    // Draw shadow if specified
    if (decoration.shadow != null) {
      final shadow = decoration.shadow!;
      final shadowPath = Path.from(path);
      shadowPath.shift(Offset(shadow.offset.dx, shadow.offset.dy));

      final shadowPaint =
          Paint()
            ..color = shadow.color
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius)
            ..style = PaintingStyle.fill;

      canvas.drawPath(shadowPath, shadowPaint);
    }

    // Fill the background
    final backgroundPaint = Paint()..style = PaintingStyle.fill;

    if (decoration.gradient != null) {
      backgroundPaint.shader = decoration.gradient!.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    } else {
      backgroundPaint.color = decoration.backgroundColor;
    }

    canvas.drawPath(path, backgroundPaint);

    // Draw the border if specified
    if (decoration.border != null) {
      final borderPaint =
          Paint()
            ..color = decoration.border!.top.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = decoration.border!.top.width
            ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, borderPaint);
    }

    // Draw the dividers if specified
    if (decoration.divider != null) {
      final divider = decoration.divider!;
      final dividerPaint =
          Paint()
            ..color = divider.color ?? Colors.grey
            ..style = PaintingStyle.stroke
            ..strokeWidth = divider.thickness ?? 1.0;

      for (int i = 0; i < sectionHeights.length - 1; i++) {
        final y = cumulativeHeights[i];
        final startX = notchRadius;
        final endX = size.width - notchRadius;

        switch (divider.style) {
          case DividerStyle.solid:
            canvas.drawLine(Offset(startX, y), Offset(endX, y), dividerPaint);
            break;

          case DividerStyle.dashed:
            final dashWidth = divider.dashWidth ?? 10.0;
            final dashSpace = divider.dashSpace ?? 7.0;
            var currentX = startX;

            while (currentX < endX) {
              final nextX = (currentX + dashWidth).clamp(currentX, endX);
              canvas.drawLine(
                Offset(currentX, y),
                Offset(nextX, y),
                dividerPaint,
              );
              currentX = nextX + dashSpace;
            }
            break;

          case DividerStyle.circles:
            final circleRadius = divider.circleRadius ?? 4.0;
            final circleSpacing = divider.circleSpacing ?? 8.0;

            // Add 2px padding from both sides
            final padding = 6.0;
            final startXWithPadding = startX + padding;
            final endXWithPadding = endX - padding;

            // Calculate the available width for circles
            final availableWidth = endXWithPadding - startXWithPadding;

            // Calculate the total width needed for one circle (diameter + spacing)
            final circleWidth = circleRadius * 2 + circleSpacing;

            // Calculate how many complete circles we can fit
            final numCircles =
                ((availableWidth + circleSpacing) / circleWidth).floor();

            // Calculate the actual spacing needed to distribute circles evenly
            final actualSpacing =
                (availableWidth - (numCircles * circleRadius * 2)) /
                (numCircles - 1);

            // Start from the left edge with padding
            var currentX = startXWithPadding + circleRadius;

            // Draw all circles
            for (int i = 0; i < numCircles; i++) {
              canvas.drawCircle(
                Offset(currentX, y),
                circleRadius,
                dividerPaint,
              );
              currentX += circleRadius * 2 + actualSpacing;
            }
            break;
        }
      }
    }
  }

  @override
  bool shouldRepaint(TicketcherPainter oldDelegate) {
    return oldDelegate.sectionHeights != sectionHeights ||
        oldDelegate.decoration != decoration;
  }
}
