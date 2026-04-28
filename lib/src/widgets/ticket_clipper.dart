import 'package:flutter/material.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/_equality.dart';
import '../painters/ticket_path_builder.dart';

/// A custom clipper for vertical tickets that matches the exact shape drawn by [VTicketcherPainter].
///
/// This clipper is used to ensure blur effects and other visual effects
/// are clipped to the exact shape of the ticket, including rounded corners
/// and notches between sections.
class VTicketcherClipper extends CustomClipper<Path> {
  /// The radius of the notches between ticket sections.
  final double notchRadius;

  /// The decoration properties for the ticket.
  final TicketcherDecoration decoration;

  /// Snapshot of each section's height at the time this clipper was created.
  /// See the note on [VTicketcherPainter.sectionHeights] — same rationale.
  final List<double> sectionHeights;

  /// Creates a new [VTicketcherClipper].
  ///
  /// All parameters are required and should match those used by the painter.
  VTicketcherClipper({
    required this.notchRadius,
    required this.decoration,
    required List<double> sectionHeights,
  }) : sectionHeights = List<double>.unmodifiable(sectionHeights);

  @override
  Path getClip(Size size) {
    return TicketPathBuilder.buildVerticalTicketPath(
      size: size,
      notchRadius: notchRadius,
      decoration: decoration,
      sectionHeights: sectionHeights,
      includeBottomPattern:
          false, // Clipping uses simplified path without patterns
    );
  }

  @override
  bool shouldReclip(covariant VTicketcherClipper oldClipper) {
    return oldClipper.notchRadius != notchRadius ||
        !listsEqualWithEpsilon(oldClipper.sectionHeights, sectionHeights) ||
        oldClipper.decoration != decoration;
  }
}

/// A custom clipper for horizontal tickets that matches the exact shape drawn by [HTicketcherPainter].
///
/// This clipper is used to ensure blur effects and other visual effects
/// are clipped to the exact shape of the ticket, including rounded corners
/// and notches between sections.
class HTicketcherClipper extends CustomClipper<Path> {
  /// The radius of the notches between ticket sections.
  final double notchRadius;

  /// The decoration properties for the ticket.
  final TicketcherDecoration decoration;

  /// Snapshot of each section's width at the time this clipper was created.
  /// See the note on [VTicketcherPainter.sectionHeights] — same rationale.
  final List<double> sectionWidths;

  /// Creates a new [HTicketcherClipper].
  ///
  /// All parameters are required and should match those used by the painter.
  HTicketcherClipper({
    required this.notchRadius,
    required this.decoration,
    required List<double> sectionWidths,
  }) : sectionWidths = List<double>.unmodifiable(sectionWidths);

  @override
  Path getClip(Size size) {
    return TicketPathBuilder.buildHorizontalTicketPath(
      size: size,
      notchRadius: notchRadius,
      decoration: decoration,
      sectionWidths: sectionWidths,
      includeEdgePatterns:
          false, // Clipping uses simplified path without patterns
    );
  }

  @override
  bool shouldReclip(covariant HTicketcherClipper oldClipper) {
    return oldClipper.notchRadius != notchRadius ||
        !listsEqualWithEpsilon(oldClipper.sectionWidths, sectionWidths) ||
        oldClipper.decoration != decoration;
  }
}
