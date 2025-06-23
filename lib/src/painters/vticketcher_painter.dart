import 'package:flutter/material.dart';
import 'package:ticketcher/src/models/border_shape.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../models/ticket_divider.dart';

/// A custom painter that draws a vertical ticket with customizable sections, borders, and dividers.
///
/// This painter is responsible for rendering the visual appearance of a vertical ticket,
/// including its borders, corners, notches between sections, and dividers.
/// It supports various border styles, corner rounding, and divider patterns.
///
/// Example:
/// ```dart
/// CustomPaint(
///   painter: VTicketcherPainter(
///     notchRadius: 10.0,
///     sectionHeights: [100.0, 100.0],
///     decoration: TicketcherDecoration(
///       borderRadius: TicketRadius.all(8.0),
///       // ... other decoration properties
///     ),
///   ),
///   child: YourTicketContent(),
/// )
/// ```
class VTicketcherPainter extends CustomPainter {
  /// The radius of the notches between ticket sections.
  final double notchRadius;

  /// The heights of each section in the ticket.
  final List<double> sectionHeights;

  /// The decoration properties for the ticket.
  final TicketcherDecoration decoration;

  /// The list of sections to be displayed in the ticket.
  final List<Section> sections;

  /// Creates a new [VTicketcherPainter].
  ///
  /// Parameters:
  /// - [notchRadius]: The radius of the notches between sections
  /// - [sectionHeights]: The heights of each section in the ticket
  /// - [decoration]: The decoration properties for the ticket
  VTicketcherPainter({
    required this.notchRadius,
    required this.sectionHeights,
    required this.decoration,
    required this.sections,
  });

  void drawStackedLayers(Canvas canvas, Size size) {
    if (decoration.stackEffect.count <= 0) return;

    final stackPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = decoration.stackEffect.color ?? Colors.grey[200]!;

    // Calculate the start position from last section
    final lastSectionStart =
        sectionHeights.length > 1
            ? sectionHeights
                .sublist(0, sectionHeights.length - 1)
                .reduce((a, b) => a + b)
            : 0.0;

    for (int i = decoration.stackEffect.count; i > 0; i--) {
      final offset = decoration.stackEffect.offset * i;
      final widthStep = decoration.stackEffect.widthStep * i;
      final rect = Rect.fromLTWH(
        widthStep / 2,
        lastSectionStart + offset,
        size.width - widthStep,
        size.height - lastSectionStart,
      );

      final path = Path();
      final radius = decoration.borderRadius.radius;

      // Draw rounded rectangle for stacked layer
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
      canvas.drawPath(path, stackPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw stacked layers first
    drawStackedLayers(canvas, size);

    final path = Path();
    final radius = decoration.borderRadius.radius;
    final direction = decoration.borderRadius.direction;
    final corner = decoration.borderRadius.corner;

    /// Determines if a specific corner should be rounded based on the decoration settings.
    ///
    /// Parameters:
    /// - [targetCorner]: The corner to check
    ///
    /// Returns:
    /// - `true` if the corner should be rounded
    /// - `false` if the corner should be sharp
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

    // Fill the ticket background
    final backgroundPaint = Paint()..style = PaintingStyle.fill;

    if (decoration.gradient != null) {
      backgroundPaint.shader = decoration.gradient!.createShader(
        Offset.zero & size,
      );
    } else {
      backgroundPaint.color = decoration.backgroundColor;
    }
    canvas.drawPath(path, backgroundPaint);

    // Draw section colors
    double currentY = 0;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      if (section.color != null) {
        var sectionHeight = sectionHeights[i];
        if (i == sections.length - 1 && decoration.bottomBorderStyle != null) {
          sectionHeight += decoration.bottomBorderStyle!.height;
        }
        final sectionRect = Rect.fromLTWH(
          0,
          currentY,
          size.width,
          sectionHeight,
        );
        final sectionPaint = Paint()..color = section.color!;
        canvas.save();
        canvas.clipPath(path);
        canvas.drawRect(sectionRect, sectionPaint);
        canvas.restore();
      }
      currentY += sectionHeights[i];
    }

    // Draw border if specified
    if (decoration.border != null) {
      final borderPaint =
          Paint()
            ..color = decoration.border!.top.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = decoration.border!.top.width
            ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, borderPaint);
    }

    // Draw dividers between ticket sections
    if (decoration.divider != null) {
      final divider = decoration.divider!;
      final dividerPaint =
          Paint()
            ..color = divider.color ?? Colors.grey
            ..style = PaintingStyle.stroke
            ..strokeWidth = divider.thickness ?? 1.0;

      for (int i = 0; i < sectionHeights.length - 1; i++) {
        final y = cumulativeHeights[i];
        final startX = notchRadius + (divider.padding ?? 0.0);
        final endX = size.width - notchRadius - (divider.padding ?? 0.0);

        switch (divider.style) {
          case DividerStyle.solid:
            canvas.drawLine(Offset(startX, y), Offset(endX, y), dividerPaint);
            break;
          case DividerStyle.dashed:
            final dashWidth = divider.dashWidth ?? 10.0;
            final dashSpace = divider.dashSpace ?? 7.0;
            final availableWidth = endX - startX;
            if (availableWidth <= 0) break;
            final numSegments =
                ((availableWidth + dashSpace) / (dashWidth + dashSpace))
                    .floor();
            if (numSegments <= 0) break;
            final adjustedDashSpace =
                (availableWidth - (numSegments * dashWidth)) /
                (numSegments > 1 ? (numSegments - 1) : 1);
            var currentX = startX;
            for (int j = 0; j < numSegments; j++) {
              canvas.drawLine(
                Offset(currentX, y),
                Offset(currentX + dashWidth, y),
                dividerPaint,
              );
              currentX += dashWidth + adjustedDashSpace;
            }
            break;
          case DividerStyle.circles:
            final circleRadius = divider.circleRadius ?? 4.0;
            final circleSpacing = divider.circleSpacing ?? 8.0;
            final availableWidth = endX - startX;
            if (availableWidth <= 0) break;
            final numCircles =
                ((availableWidth + circleSpacing) /
                        (2 * circleRadius + circleSpacing))
                    .floor();
            if (numCircles <= 0) break;
            final adjustedCircleSpace =
                (availableWidth - (numCircles * 2 * circleRadius)) /
                (numCircles > 1 ? (numCircles - 1) : 1);
            var currentX = startX + circleRadius;
            final circlePaint =
                Paint()
                  ..color = divider.color ?? Colors.grey
                  ..style = PaintingStyle.fill;

            for (int j = 0; j < numCircles; j++) {
              canvas.drawCircle(Offset(currentX, y), circleRadius, circlePaint);
              currentX += 2 * circleRadius + adjustedCircleSpace;
            }
            break;
          case DividerStyle.dotted:
            final dotSize = divider.dotSize ?? 2.0;
            final dotSpacing = divider.dotSpacing ?? 8.0;
            final availableWidth = endX - startX;
            if (availableWidth <= 0) break;
            final numDots =
                ((availableWidth + dotSpacing) / (dotSize + dotSpacing))
                    .floor();
            if (numDots <= 0) break;
            final adjustedDotSpace =
                (availableWidth - (numDots * dotSize)) /
                (numDots > 1 ? (numDots - 1) : 1);
            var currentX = startX;
            final dotPaint =
                Paint()
                  ..color = divider.color ?? Colors.grey
                  ..style = PaintingStyle.fill;
            for (int j = 0; j < numDots; j++) {
              canvas.drawCircle(
                Offset(currentX + dotSize / 2, y),
                dotSize / 2,
                dotPaint,
              );
              currentX += dotSize + adjustedDotSpace;
            }
            break;
          case DividerStyle.doubleLine:
            final lineSpacing = divider.lineSpacing ?? 4.0;
            canvas.drawLine(
              Offset(startX, y - lineSpacing / 2),
              Offset(endX, y - lineSpacing / 2),
              dividerPaint,
            );
            canvas.drawLine(
              Offset(startX, y + lineSpacing / 2),
              Offset(endX, y + lineSpacing / 2),
              dividerPaint,
            );
            break;
          case DividerStyle.wave:
            final path = Path();
            path.moveTo(startX, y);
            final waveHeight = divider.waveHeight ?? 4.0;
            final waveWidth = divider.waveWidth ?? 8.0;
            final availableWidth = endX - startX;
            final numWaves = (availableWidth / waveWidth).floor();
            if (numWaves <= 0) break;
            final adjustedWaveWidth = availableWidth / numWaves;
            var currentX = startX;

            for (int j = 0; j < numWaves; j++) {
              final midX = currentX + adjustedWaveWidth / 2;
              final endX = currentX + adjustedWaveWidth;
              path.quadraticBezierTo(midX, y + waveHeight, endX, y);
              currentX = endX;
            }
            canvas.drawPath(path, dividerPaint);
            break;
          case DividerStyle.smoothWave:
            final path = Path();
            path.moveTo(startX, y);
            final waveHeight = divider.waveHeight ?? 8.0; // amplitude
            final waveWidth = divider.waveWidth ?? 8.0; // wave period
            final availableWidth = endX - startX;
            final numWaves = (availableWidth / waveWidth).floor();
            if (numWaves <= 0) break;
            final adjustedWaveWidth = availableWidth / numWaves;
            var currentX = startX;

            for (int j = 0; j < numWaves; j++) {
              final midX = currentX + adjustedWaveWidth / 2;
              final endX = currentX + adjustedWaveWidth;
              // Alternate wave direction
              final currentWaveHeight = (j % 2 == 0) ? waveHeight : -waveHeight;
              path.quadraticBezierTo(midX, y + currentWaveHeight, endX, y);
              currentX = endX;
            }
            canvas.drawPath(path, dividerPaint);
            break;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant VTicketcherPainter oldDelegate) {
    return oldDelegate.notchRadius != notchRadius ||
        oldDelegate.sectionHeights != sectionHeights ||
        oldDelegate.decoration != decoration;
  }
}
