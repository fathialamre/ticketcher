import 'package:flutter/material.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../models/ticket_divider.dart';
import '../models/border_shape.dart';

/// A custom painter that draws a horizontal ticket with customizable sections, borders, and dividers.
///
/// This painter renders a horizontal ticket with customizable visual elements including:
/// - Rounded corners with configurable radius and direction
/// - Notches between sections
/// - Border patterns (wave, sharp, arc)
/// - Section dividers with various styles (solid, dashed, dotted, etc.)
/// - Background colors/gradients
/// - Drop shadows
/// - Stack effects
///
/// The ticket can be divided into multiple sections of specified widths, with
/// dividers and notches automatically placed between them.
///
/// Example usage:
/// ```dart
/// CustomPaint(
///   painter: HTicketcherPainter(
///     notchRadius: 10.0,
///     sectionWidths: [100.0, 100.0],
///     decoration: TicketcherDecoration(
///       borderRadius: TicketRadius.all(8.0),
///       backgroundColor: Colors.white,
///       border: Border.all(color: Colors.grey),
///       divider: TicketDivider.doubleLine(
///         color: Colors.grey,
///         thickness: 1.0,
///         lineSpacing: 4.0,
///       ),
///     ),
///   ),
///   child: YourTicketContent(),
/// )
/// ```
class HTicketcherPainter extends CustomPainter {
  /// The radius of the notches between ticket sections.
  ///
  /// Controls the curvature of the cutouts between each section.
  /// A larger value creates more rounded notches.
  final double notchRadius;

  /// The widths of each section in the ticket.
  ///
  /// Each value represents the width of one section from left to right.
  /// The number of sections is determined by the length of this list.
  /// Dividers and notches are automatically placed between sections.
  final List<double> sectionWidths;

  /// The decoration properties for the ticket.
  ///
  /// Controls the visual appearance including:
  /// - Border radius and direction
  /// - Background color/gradient
  /// - Border style and pattern
  /// - Divider style and appearance
  /// - Shadow effects
  /// - Stack effects
  final TicketcherDecoration decoration;

  /// Creates a new [HTicketcherPainter].
  ///
  /// All parameters are required:
  /// - [notchRadius]: Controls the roundness of notches between sections
  /// - [sectionWidths]: Defines the width of each ticket section
  /// - [decoration]: Specifies all visual styling properties
  HTicketcherPainter({
    required this.notchRadius,
    required this.sectionWidths,
    required this.decoration,
  });

  void drawStackedLayers(Canvas canvas, Size size) {
    // Stack effect is only supported in vertical tickets
    return;
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

    // Calculate cumulative widths for each section
    List<double> cumulativeWidths = [];
    double currentWidth = 0;
    for (double width in sectionWidths) {
      currentWidth += width;
      cumulativeWidths.add(currentWidth);
    }

    // Draw top edge with notches
    for (int i = 0; i < sectionWidths.length - 1; i++) {
      final notchX = cumulativeWidths[i];

      // Line to notch
      path.lineTo(notchX - notchRadius, 0);

      // Top notch
      path.arcToPoint(
        Offset(notchX + notchRadius, 0),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // Top edge to right
    path.lineTo(
      size.width - (shouldRoundCorner(TicketCorner.topRight) ? radius : 0),
      0,
    );

    // Top-right corner
    if (shouldRoundCorner(TicketCorner.topRight)) {
      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Right edge with optional pattern
    if (decoration.rightBorderStyle != null) {
      final style = decoration.rightBorderStyle!;
      final availableHeight =
          size.height -
          (shouldRoundCorner(TicketCorner.topRight) ? radius : 0) -
          (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0);

      if (style.shape == BorderShape.arc) {
        // Calculate dimensions for arc pattern
        final arcHeight = style.height * 2;
        final gapHeight = style.height;
        final numArcs =
            ((availableHeight - gapHeight) / (arcHeight + gapHeight)).floor();
        final totalPatternHeight =
            (numArcs * (arcHeight + gapHeight)) + gapHeight;
        final extraGapHeight =
            (availableHeight - totalPatternHeight) / (numArcs + 1);
        var currentY = shouldRoundCorner(TicketCorner.topRight) ? radius : 0;

        // Draw initial gap
        path.lineTo(size.width, currentY + gapHeight + extraGapHeight);
        currentY += gapHeight + extraGapHeight;

        // Draw arcs
        for (int i = 0; i < numArcs; i++) {
          path.arcToPoint(
            Offset(size.width, currentY + arcHeight),
            radius: Radius.circular(style.height),
            clockwise: false,
          );
          currentY += arcHeight;

          if (i < numArcs - 1) {
            path.lineTo(size.width, currentY + gapHeight + extraGapHeight);
            currentY += gapHeight + extraGapHeight;
          }
        }

        // Draw final gap if needed
        if (currentY <
            size.height -
                (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0)) {
          path.lineTo(
            size.width,
            size.height -
                (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0),
          );
        }
      } else {
        // Calculate dimensions for wave/sharp patterns
        final numSegments = (availableHeight / style.height).floor();
        final adjustedHeight = availableHeight / numSegments;
        var currentY = shouldRoundCorner(TicketCorner.topRight) ? radius : 0;

        while (currentY <
            size.height -
                (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0)) {
          final nextY = (currentY + adjustedHeight).clamp(
            currentY.toDouble(),
            (size.height -
                    (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0))
                .toDouble(),
          );
          final midY = (currentY + nextY) / 2;

          switch (style.shape) {
            case BorderShape.wave:
              path.quadraticBezierTo(
                size.width + style.width,
                midY,
                size.width,
                nextY,
              );
              break;
            case BorderShape.sharp:
              path.lineTo(size.width + style.width, midY);
              path.lineTo(size.width, nextY);
              break;
            case BorderShape.arc:
              // Handled above
              break;
          }
          currentY = nextY;
        }
      }
    } else {
      // Regular straight right edge
      path.lineTo(
        size.width,
        size.height -
            (shouldRoundCorner(TicketCorner.bottomRight) ? radius : 0),
      );
    }

    // Bottom-right corner
    if (shouldRoundCorner(TicketCorner.bottomRight)) {
      path.arcToPoint(
        Offset(size.width - radius, size.height),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Bottom edge with notches
    for (int i = sectionWidths.length - 2; i >= 0; i--) {
      final notchX = cumulativeWidths[i];

      // Line to notch
      path.lineTo(notchX + notchRadius, size.height);

      // Bottom notch
      path.arcToPoint(
        Offset(notchX - notchRadius, size.height),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // Bottom edge to left
    path.lineTo(
      shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0,
      size.height,
    );

    // Bottom-left corner
    if (shouldRoundCorner(TicketCorner.bottomLeft)) {
      path.arcToPoint(
        Offset(0, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Left edge with optional pattern
    if (decoration.leftBorderStyle != null) {
      final style = decoration.leftBorderStyle!;
      final availableHeight =
          size.height -
          (shouldRoundCorner(TicketCorner.topLeft) ? radius : 0) -
          (shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0);

      if (style.shape == BorderShape.arc) {
        // Calculate dimensions for arc pattern
        final arcHeight = style.height * 2;
        final gapHeight = style.height;
        final numArcs =
            ((availableHeight - gapHeight) / (arcHeight + gapHeight)).floor();
        final totalPatternHeight =
            (numArcs * (arcHeight + gapHeight)) + gapHeight;
        final extraGapHeight =
            (availableHeight - totalPatternHeight) / (numArcs + 1);
        var currentY =
            size.height -
            (shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0);

        // Draw initial gap
        path.lineTo(0, currentY - (gapHeight + extraGapHeight));
        currentY -= (gapHeight + extraGapHeight);

        // Draw arcs from bottom to top
        for (int i = 0; i < numArcs; i++) {
          path.arcToPoint(
            Offset(0, currentY - arcHeight),
            radius: Radius.circular(style.height),
            clockwise: false,
          );
          currentY -= arcHeight;

          if (i < numArcs - 1) {
            path.lineTo(0, currentY - (gapHeight + extraGapHeight));
            currentY -= (gapHeight + extraGapHeight);
          }
        }

        // Draw final gap if needed
        if (currentY > (shouldRoundCorner(TicketCorner.topLeft) ? radius : 0)) {
          path.lineTo(0, shouldRoundCorner(TicketCorner.topLeft) ? radius : 0);
        }
      } else {
        // Calculate dimensions for wave/sharp patterns
        final numSegments = (availableHeight / style.height).floor();
        final adjustedHeight = availableHeight / numSegments;
        var currentY =
            size.height -
            (shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0);

        while (currentY >
            (shouldRoundCorner(TicketCorner.topLeft) ? radius : 0)) {
          final nextY = (currentY - adjustedHeight).clamp(
            (shouldRoundCorner(TicketCorner.topLeft) ? radius : 0).toDouble(),
            currentY.toDouble(),
          );
          final midY = (currentY + nextY) / 2;

          switch (style.shape) {
            case BorderShape.wave:
              path.quadraticBezierTo(-style.width, midY, 0, nextY);
              break;
            case BorderShape.sharp:
              path.lineTo(-style.width, midY);
              path.lineTo(0, nextY);
              break;
            case BorderShape.arc:
              // Handled above
              break;
          }
          currentY = nextY;
        }
      }
    } else {
      // Regular straight left edge
      path.lineTo(0, shouldRoundCorner(TicketCorner.topLeft) ? radius : 0);
    }

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

    /// Draws the background of the ticket with the specified decoration.
    ///
    /// Handles both solid colors and gradients. For gradients, creates a shader
    /// that fills the entire ticket area. For solid colors, uses the specified
    /// background color.
    void drawBackground() {
      if (decoration.gradient != null) {
        backgroundPaint.shader = decoration.gradient!.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );
      } else {
        backgroundPaint.color = decoration.backgroundColor;
      }
      canvas.drawPath(path, backgroundPaint);
    }

    /// Draws the border of the ticket with the specified decoration.
    ///
    /// If a border is specified in the decoration, draws it using the configured
    /// color and width. The border follows the entire ticket path including
    /// corners, notches, and any border patterns.
    void drawBorder() {
      if (decoration.border != null) {
        final borderPaint =
            Paint()
              ..color = decoration.border!.top.color
              ..style = PaintingStyle.stroke
              ..strokeWidth = decoration.border!.top.width
              ..strokeJoin = StrokeJoin.round;
        canvas.drawPath(path, borderPaint);
      }
    }

    /// Draws dividers between ticket sections using the specified style.
    ///
    /// Supports multiple divider styles:
    /// - Solid: Single continuous line
    /// - Dashed: Series of dashes with configurable length and spacing
    /// - Circles: Series of circles with configurable size and spacing
    /// - Wave: Zigzag pattern with configurable width and height
    /// - Smooth Wave: Curved wave pattern using Bezier curves
    /// - Dotted: Series of dots with configurable size and spacing
    /// - Double Line: Two parallel lines with configurable spacing
    void drawDividers() {
      if (decoration.divider == null) return;

      final divider = decoration.divider!;
      final dividerPaint =
          Paint()
            ..color = divider.color ?? Colors.grey
            ..style = PaintingStyle.stroke
            ..strokeWidth = divider.thickness ?? 1.0;

      for (int i = 0; i < sectionWidths.length - 1; i++) {
        final x = cumulativeWidths[i];
        final startY = notchRadius + (divider.padding ?? 0.0);
        final endY = size.height - notchRadius - (divider.padding ?? 0.0);

        switch (divider.style) {
          case DividerStyle.solid:
            canvas.drawLine(Offset(x, startY), Offset(x, endY), dividerPaint);
            break;

          case DividerStyle.dashed:
            final dashHeight = divider.dashWidth ?? 10.0;
            final dashSpace = divider.dashSpace ?? 7.0;

            // Calculate the available height for dashes
            final availableHeight = endY - startY;

            // Calculate the total height needed for one dash segment (dash + space)
            final segmentHeight = dashHeight + dashSpace;

            // Calculate how many complete segments we can fit
            final numSegments =
                ((availableHeight + dashSpace) / segmentHeight).floor();

            // Calculate the actual spacing needed to distribute dashes evenly
            final actualSpacing =
                (availableHeight - (numSegments * dashHeight)) /
                (numSegments - 1);

            // Start from the top edge
            var currentY = startY;

            // Draw all dashes
            for (int i = 0; i < numSegments; i++) {
              final nextY = currentY + dashHeight;
              canvas.drawLine(
                Offset(x, currentY),
                Offset(x, nextY),
                dividerPaint,
              );
              currentY = nextY + actualSpacing;
            }
            break;

          case DividerStyle.circles:
            final circleRadius = divider.circleRadius ?? 4.0;
            final circleSpacing = divider.circleSpacing ?? 8.0;

            // Calculate the available height for circles
            final availableHeight = endY - startY;

            // Calculate the total height needed for one circle (diameter + spacing)
            final circleHeight = circleRadius * 2 + circleSpacing;

            // Calculate how many complete circles we can fit
            final numCircles =
                ((availableHeight + circleSpacing) / circleHeight).floor();

            // Calculate the actual spacing needed to distribute circles evenly
            final actualSpacing =
                (availableHeight - (numCircles * circleRadius * 2)) /
                (numCircles - 1);

            // Start from the top edge
            var currentY = startY + circleRadius;

            // Draw all circles
            for (int i = 0; i < numCircles; i++) {
              canvas.drawCircle(
                Offset(x, currentY),
                circleRadius,
                dividerPaint,
              );
              currentY += circleRadius * 2 + actualSpacing;
            }
            break;

          case DividerStyle.wave:
            final waveWidth = divider.waveWidth ?? 4.0;
            final waveHeight = divider.waveHeight ?? 8.0;

            // Calculate the available height for waves
            final availableHeight = endY - startY;

            // Calculate how many complete waves we can fit
            final numWaves = (availableHeight / waveHeight).floor();

            // Calculate the actual wave height to distribute evenly
            final actualWaveHeight = availableHeight / numWaves;

            // Start from the top edge
            var currentY = startY;

            // Draw the wave pattern
            for (int i = 0; i < numWaves; i++) {
              final nextY = currentY + actualWaveHeight;
              final midY = (currentY + nextY) / 2;

              // Draw a single wave segment
              canvas.drawLine(
                Offset(x, currentY),
                Offset(x + waveWidth, midY),
                dividerPaint,
              );
              canvas.drawLine(
                Offset(x + waveWidth, midY),
                Offset(x, nextY),
                dividerPaint,
              );

              currentY = nextY;
            }
            break;

          case DividerStyle.smoothWave:
            final waveWidth = divider.waveWidth ?? 4.0;
            final waveHeight = divider.waveHeight ?? 8.0;

            // Calculate the available height for waves
            final availableHeight = endY - startY;

            // Calculate how many complete waves we can fit
            final numWaves = (availableHeight / waveHeight).floor();

            // Calculate the actual wave height to distribute evenly
            final actualWaveHeight = availableHeight / numWaves;

            // Start from the top edge
            var currentY = startY;

            // Draw the smooth wave pattern
            for (int i = 0; i < numWaves; i++) {
              final nextY = currentY + actualWaveHeight;
              final midY = (currentY + nextY) / 2;

              // Draw a smooth wave segment using quadratic Bezier curve
              final path =
                  Path()
                    ..moveTo(x, currentY)
                    ..quadraticBezierTo(x + waveWidth, midY, x, nextY);

              canvas.drawPath(path, dividerPaint);
              currentY = nextY;
            }
            break;

          case DividerStyle.dotted:
            final dotSize = divider.dotSize ?? 4.0;
            final dotSpacing = divider.dotSpacing ?? 8.0;

            // Calculate the available height for dots
            final availableHeight = endY - startY;

            // Calculate the total height needed for one dot segment (dot + spacing)
            final segmentHeight = dotSize + dotSpacing;

            // Calculate how many complete segments we can fit
            final numSegments =
                ((availableHeight + dotSpacing) / segmentHeight).floor();

            // Calculate the actual spacing needed to distribute dots evenly
            final actualSpacing =
                (availableHeight - (numSegments * dotSize)) / (numSegments - 1);

            // Start from the top edge
            var currentY = startY;

            // Draw all dots
            for (int i = 0; i < numSegments; i++) {
              canvas.drawCircle(
                Offset(x, currentY + dotSize / 2),
                dotSize / 2,
                dividerPaint,
              );
              currentY += dotSize + actualSpacing;
            }
            break;

          case DividerStyle.doubleLine:
            final lineSpacing = divider.lineSpacing ?? 4.0;
            final halfSpacing = lineSpacing / 2;

            // Draw the left line
            canvas.drawLine(
              Offset(x - halfSpacing, startY),
              Offset(x - halfSpacing, endY),
              dividerPaint,
            );

            // Draw the right line
            canvas.drawLine(
              Offset(x + halfSpacing, startY),
              Offset(x + halfSpacing, endY),
              dividerPaint,
            );
            break;
        }
      }
    }

    // Draw the ticket components in the correct order
    drawBackground();
    drawBorder();
    drawDividers();
  }

  @override
  bool shouldRepaint(covariant HTicketcherPainter oldDelegate) {
    return oldDelegate.notchRadius != notchRadius ||
        oldDelegate.sectionWidths != sectionWidths ||
        oldDelegate.decoration != decoration;
  }
}
