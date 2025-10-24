import 'package:flutter/material.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';

/// Utility class for building ticket paths for both painting and clipping.
///
/// This class provides static methods to create the complex paths used by
/// ticket widgets, including rounded corners, notches between sections,
/// and border patterns. The same path logic is used for both painting
/// and clipping to ensure consistency.
class TicketPathBuilder {
  /// Builds a path for a vertical ticket.
  ///
  /// Parameters:
  /// - [size]: The size of the ticket
  /// - [notchRadius]: The radius of the notches between sections
  /// - [decoration]: The decoration properties for the ticket
  /// - [sectionHeights]: The heights of each section
  /// - [includeBottomPattern]: Whether to include the bottom border pattern (for painting)
  ///
  /// Returns a [Path] object representing the ticket outline.
  static Path buildVerticalTicketPath({
    required Size size,
    required double notchRadius,
    required TicketcherDecoration decoration,
    required List<double> sectionHeights,
    bool includeBottomPattern = false,
  }) {
    final path = Path();
    final radius = decoration.borderRadius.radius;
    final direction = decoration.borderRadius.direction;
    final corner = decoration.borderRadius.corner;

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

    // Bottom edge (simplified version without pattern for clipping)
    if (includeBottomPattern && decoration.bottomBorderStyle != null) {
      // For painting, this would include the border pattern
      // For clipping, we skip the pattern and use straight line
      path.lineTo(
        shouldRoundCorner(TicketCorner.bottomLeft) ? radius : 0,
        size.height,
      );
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

    // Close the path
    path.close();
    return path;
  }

  /// Builds a path for a horizontal ticket.
  ///
  /// Parameters:
  /// - [size]: The size of the ticket
  /// - [notchRadius]: The radius of the notches between sections
  /// - [decoration]: The decoration properties for the ticket
  /// - [sectionWidths]: The widths of each section
  /// - [includeEdgePatterns]: Whether to include edge border patterns (for painting)
  ///
  /// Returns a [Path] object representing the ticket outline.
  static Path buildHorizontalTicketPath({
    required Size size,
    required double notchRadius,
    required TicketcherDecoration decoration,
    required List<double> sectionWidths,
    bool includeEdgePatterns = false,
  }) {
    final path = Path();
    final radius = decoration.borderRadius.radius;
    final direction = decoration.borderRadius.direction;
    final corner = decoration.borderRadius.corner;

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

    // Right edge (simplified without pattern for clipping)
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

    // Left edge (simplified without pattern for clipping)
    path.lineTo(0, shouldRoundCorner(TicketCorner.topLeft) ? radius : 0);

    // Top-left corner
    if (shouldRoundCorner(TicketCorner.topLeft)) {
      path.arcToPoint(
        Offset(radius, 0),
        radius: Radius.circular(radius),
        clockwise: direction == RadiusDirection.inward,
      );
    }

    // Close the path
    path.close();
    return path;
  }
}
