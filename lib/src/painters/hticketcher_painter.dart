import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../models/ticket_divider.dart';
import '../models/border_shape.dart';
import '../models/ticket_watermark.dart';
import 'ticket_path_builder.dart';

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

  /// The list of sections to be displayed in the ticket.
  final List<Section> sections;

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
    required this.sections,
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
    double currentX = 0;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      if (section.color != null) {
        var sectionWidth = sectionWidths[i];
        var sectionX = currentX;
        if (i == 0 && decoration.leftBorderStyle != null) {
          sectionWidth += decoration.leftBorderStyle!.width;
          sectionX -= decoration.leftBorderStyle!.width;
        }
        if (i == sections.length - 1 && decoration.rightBorderStyle != null) {
          sectionWidth += decoration.rightBorderStyle!.width;
        }
        final sectionRect = Rect.fromLTWH(
          sectionX,
          0,
          sectionWidth,
          size.height,
        );
        final sectionPaint = Paint()..color = section.color!;
        canvas.save();
        canvas.clipPath(path);
        canvas.drawRect(sectionRect, sectionPaint);
        canvas.restore();
      }
      currentX += sectionWidths[i];
    }

    // Draw border if specified
    if (decoration.border != null || decoration.borderGradient != null) {
      final borderPaint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeJoin = StrokeJoin.round;

      if (decoration.borderGradient != null) {
        // Use gradient border
        borderPaint.shader = decoration.borderGradient!.createShader(
          Offset.zero & size,
        );
        borderPaint.strokeWidth = decoration.borderWidth;
      } else if (decoration.border != null) {
        // Use solid color border
        borderPaint.color = decoration.border!.top.color;
        borderPaint.strokeWidth = decoration.border!.top.width;
      }

      canvas.drawPath(path, borderPaint);
    }

    // Draw dividers between ticket sections using the specified style.
    if (decoration.divider != null) {
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
            final availableHeight = endY - startY;
            if (availableHeight <= 0) break;
            final numSegments =
                ((availableHeight + dashSpace) / (dashHeight + dashSpace))
                    .floor();
            if (numSegments <= 0) break;
            final adjustedDashSpace =
                (availableHeight - (numSegments * dashHeight)) /
                (numSegments > 1 ? (numSegments - 1) : 1);
            var currentY = startY;
            for (int j = 0; j < numSegments; j++) {
              canvas.drawLine(
                Offset(x, currentY),
                Offset(x, currentY + dashHeight),
                dividerPaint,
              );
              currentY += dashHeight + adjustedDashSpace;
            }
            break;
          case DividerStyle.circles:
            final circleRadius = divider.circleRadius ?? 4.0;
            final circleSpacing = divider.circleSpacing ?? 8.0;
            final availableHeight = endY - startY;
            if (availableHeight <= 0) break;
            final numCircles =
                ((availableHeight + circleSpacing) /
                        (2 * circleRadius + circleSpacing))
                    .floor();
            if (numCircles <= 0) break;
            final adjustedCircleSpace =
                (availableHeight - (numCircles * 2 * circleRadius)) /
                (numCircles > 1 ? (numCircles - 1) : 1);
            var currentY = startY + circleRadius;
            final circlePaint =
                Paint()
                  ..color = divider.color ?? Colors.grey
                  ..style = PaintingStyle.fill;

            for (int j = 0; j < numCircles; j++) {
              canvas.drawCircle(Offset(x, currentY), circleRadius, circlePaint);
              currentY += 2 * circleRadius + adjustedCircleSpace;
            }
            break;
          case DividerStyle.dotted:
            final dotSize = divider.dotSize ?? 2.0;
            final dotSpacing = divider.dotSpacing ?? 8.0;
            final availableHeight = endY - startY;
            if (availableHeight <= 0) break;
            final numDots =
                ((availableHeight + dotSpacing) / (dotSize + dotSpacing))
                    .floor();
            if (numDots <= 0) break;
            final adjustedDotSpace =
                (availableHeight - (numDots * dotSize)) /
                (numDots > 1 ? (numDots - 1) : 1);
            var currentY = startY;
            final dotPaint =
                Paint()
                  ..color = divider.color ?? Colors.grey
                  ..style = PaintingStyle.fill;
            for (int j = 0; j < numDots; j++) {
              canvas.drawCircle(
                Offset(x, currentY + dotSize / 2),
                dotSize / 2,
                dotPaint,
              );
              currentY += dotSize + adjustedDotSpace;
            }
            break;
          case DividerStyle.doubleLine:
            final lineSpacing = divider.lineSpacing ?? 4.0;
            canvas.drawLine(
              Offset(x - lineSpacing / 2, startY),
              Offset(x - lineSpacing / 2, endY),
              dividerPaint,
            );
            canvas.drawLine(
              Offset(x + lineSpacing / 2, startY),
              Offset(x + lineSpacing / 2, endY),
              dividerPaint,
            );
            break;
          case DividerStyle.wave:
            final path = Path();
            path.moveTo(x, startY);
            final waveHeight = divider.waveHeight ?? 4.0;
            final waveWidth = divider.waveWidth ?? 8.0;
            final availableHeight = endY - startY;
            final numWaves = (availableHeight / waveHeight).floor();
            if (numWaves <= 0) break;
            final adjustedWaveHeight = availableHeight / numWaves;
            var currentY = startY;

            for (int j = 0; j < numWaves; j++) {
              final midY = currentY + adjustedWaveHeight / 2;
              final endY = currentY + adjustedWaveHeight;
              path.quadraticBezierTo(x + waveWidth, midY, x, endY);
              currentY = endY;
            }
            canvas.drawPath(path, dividerPaint);
            break;
          case DividerStyle.smoothWave:
            final path = Path();
            path.moveTo(x, startY);
            final waveHeight = divider.waveHeight ?? 8.0; // wave period
            final waveWidth = divider.waveWidth ?? 8.0; // amplitude
            final availableHeight = endY - startY;
            final numWaves = (availableHeight / waveHeight).floor();
            if (numWaves <= 0) break;
            final adjustedWaveHeight = availableHeight / numWaves;
            var currentY = startY;

            for (int j = 0; j < numWaves; j++) {
              final midY = currentY + adjustedWaveHeight / 2;
              final endY = currentY + adjustedWaveHeight;
              // Alternate wave direction
              final currentWaveWidth = (j % 2 == 0) ? waveWidth : -waveWidth;
              path.quadraticBezierTo(x + currentWaveWidth, midY, x, endY);
              currentY = endY;
            }
            canvas.drawPath(path, dividerPaint);
            break;
        }
      }
    }

    // Draw watermark if specified
    drawWatermark(canvas, size);
  }

  /// Draws the watermark on the ticket if one is specified in the decoration.
  void drawWatermark(Canvas canvas, Size size) {
    final watermark = decoration.watermark;
    if (watermark == null) return;

    canvas.save();

    if (watermark.type == WatermarkType.text) {
      _drawTextWatermark(canvas, size, watermark);
    }
    // Widget watermarks are handled in the widget layer, not in the painter

    canvas.restore();
  }

  /// Draws a text-based watermark
  void _drawTextWatermark(Canvas canvas, Size size, TicketWatermark watermark) {
    if (watermark.text == null) return;

    final textStyle =
        watermark.textStyle ??
        const TextStyle(
          fontSize: 24,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        );

    final textPainter = TextPainter(
      text: TextSpan(
        text: watermark.text!,
        style: textStyle.copyWith(
          color:
              textStyle.color?.withOpacity(watermark.opacity) ??
              Colors.grey.withOpacity(watermark.opacity),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    if (watermark.repeat) {
      _drawRepeatedTextWatermark(canvas, size, watermark, textPainter);
    } else {
      _drawSingleTextWatermark(canvas, size, watermark, textPainter);
    }
  }

  /// Draws a single text watermark at the specified position
  void _drawSingleTextWatermark(
    Canvas canvas,
    Size size,
    TicketWatermark watermark,
    TextPainter textPainter,
  ) {
    final alignment = watermark.flutterAlignment;
    final textSize = textPainter.size;

    // Calculate position based on alignment
    final centerX =
        alignment.x * (size.width - textSize.width) / 2 + size.width / 2;
    final centerY =
        alignment.y * (size.height - textSize.height) / 2 + size.height / 2;

    final position = Offset(
      centerX - textSize.width / 2 + watermark.offset.dx,
      centerY - textSize.height / 2 + watermark.offset.dy,
    );

    // Apply rotation if specified
    if (watermark.rotation != 0) {
      canvas.save();
      canvas.translate(
        position.dx + textSize.width / 2,
        position.dy + textSize.height / 2,
      );
      canvas.rotate(
        watermark.rotation * 3.14159 / 180,
      ); // Convert degrees to radians
      canvas.translate(-textSize.width / 2, -textSize.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    } else {
      textPainter.paint(canvas, position);
    }
  }

  /// Draws repeated text watermarks across the ticket
  void _drawRepeatedTextWatermark(
    Canvas canvas,
    Size size,
    TicketWatermark watermark,
    TextPainter textPainter,
  ) {
    final textSize = textPainter.size;
    final spacing = watermark.repeatSpacing;

    // Add padding to keep watermarks within ticket bounds
    final padding = 20.0;
    final availableWidth = size.width - (padding * 2);
    final availableHeight = size.height - (padding * 2);

    // Calculate how many watermarks can fit within the padded bounds
    final horizontalCount =
        (availableWidth / (textSize.width + spacing)).floor();
    final verticalCount =
        (availableHeight / (textSize.height + spacing)).floor();

    // Ensure we have at least 1 watermark
    final actualHorizontalCount = horizontalCount > 0 ? horizontalCount : 1;
    final actualVerticalCount = verticalCount > 0 ? verticalCount : 1;

    // Center the pattern within the available space
    final totalPatternWidth =
        actualHorizontalCount * textSize.width +
        (actualHorizontalCount - 1) * spacing;
    final totalPatternHeight =
        actualVerticalCount * textSize.height +
        (actualVerticalCount - 1) * spacing;

    final startX = padding + (availableWidth - totalPatternWidth) / 2;
    final startY = padding + (availableHeight - totalPatternHeight) / 2;

    // Create clipping path to ensure watermarks stay within ticket bounds
    canvas.save();
    final clipPath = _createTicketPath(size);
    canvas.clipPath(clipPath);

    for (int i = 0; i < actualHorizontalCount; i++) {
      for (int j = 0; j < actualVerticalCount; j++) {
        final x = startX + i * (textSize.width + spacing);
        final y = startY + j * (textSize.height + spacing);

        // Check if the watermark would be within bounds
        if (x >= 0 &&
            y >= 0 &&
            x + textSize.width <= size.width &&
            y + textSize.height <= size.height) {
          if (watermark.rotation != 0) {
            canvas.save();
            canvas.translate(x + textSize.width / 2, y + textSize.height / 2);
            canvas.rotate(watermark.rotation * 3.14159 / 180);
            canvas.translate(-textSize.width / 2, -textSize.height / 2);
            textPainter.paint(canvas, Offset.zero);
            canvas.restore();
          } else {
            textPainter.paint(canvas, Offset(x, y));
          }
        }
      }
    }

    canvas.restore();
  }

  /// Creates the ticket path for clipping watermarks
  Path _createTicketPath(Size size) {
    return TicketPathBuilder.buildHorizontalTicketPath(
      size: size,
      notchRadius: notchRadius,
      decoration: decoration,
      sectionWidths: sectionWidths,
      includeEdgePatterns: false,
    );
  }

  @override
  bool shouldRepaint(covariant HTicketcherPainter oldDelegate) {
    return oldDelegate.notchRadius != notchRadius ||
        oldDelegate.sectionWidths != sectionWidths ||
        oldDelegate.decoration != decoration;
  }
}
