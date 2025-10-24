import 'package:flutter/material.dart';
import '../models/ticketcher_decoration.dart';
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

  /// The heights of each section in the ticket.
  final List<double> sectionHeights;

  /// Creates a new [VTicketcherClipper].
  ///
  /// All parameters are required and should match those used by the painter.
  const VTicketcherClipper({
    required this.notchRadius,
    required this.decoration,
    required this.sectionHeights,
  });

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
        oldClipper.sectionHeights != sectionHeights ||
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

  /// The widths of each section in the ticket.
  final List<double> sectionWidths;

  /// Creates a new [HTicketcherClipper].
  ///
  /// All parameters are required and should match those used by the painter.
  const HTicketcherClipper({
    required this.notchRadius,
    required this.decoration,
    required this.sectionWidths,
  });

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
        oldClipper.sectionWidths != sectionWidths ||
        oldClipper.decoration != decoration;
  }
}
