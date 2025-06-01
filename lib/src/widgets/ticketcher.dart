import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import 'hticketcher.dart';
import 'vticketcher.dart';

/// A factory widget that creates either horizontal or vertical tickets.
///
/// The [Ticketcher] widget serves as a convenient factory for creating tickets
/// in either horizontal or vertical orientation. It delegates the actual rendering
/// to either [HTicketcher] or [VTicketcher] based on the [isHorizontal] flag.
///
/// Example:
/// ```dart
/// // Create a vertical ticket
/// Ticketcher(
///   sections: [
///     Section(
///       child: Text('Header'),
///       padding: EdgeInsets.all(16),
///     ),
///     Section(
///       child: Text('Content'),
///       padding: EdgeInsets.all(16),
///     ),
///   ],
///   width: 300,
///   decoration: TicketcherDecoration(
///     borderRadius: TicketRadius.all(8.0),
///     backgroundColor: Colors.white,
///   ),
/// )
///
/// // Create a horizontal ticket
/// Ticketcher.horizontal(
///   sections: [
///     Section(
///       child: Text('Left Section'),
///       padding: EdgeInsets.all(16),
///     ),
///     Section(
///       child: Text('Right Section'),
///       padding: EdgeInsets.all(16),
///     ),
///   ],
///   height: 200,
///   decoration: TicketcherDecoration(
///     borderRadius: TicketRadius.all(8.0),
///     backgroundColor: Colors.white,
///   ),
/// )
/// ```
class Ticketcher extends StatelessWidget {
  /// The list of sections to be displayed in the ticket.
  ///
  /// Each section represents a distinct part of the ticket with its own content
  /// and padding. The sections are arranged based on the ticket orientation.
  final List<Section> sections;

  /// The radius of the notches between ticket sections.
  ///
  /// This determines how rounded the cutouts between sections will be.
  /// Defaults to 10.0.
  final double notchRadius;

  /// The width of the ticket.
  ///
  /// For vertical tickets, this sets the fixed width.
  /// For horizontal tickets, this is optional as the width is determined by content.
  final double? width;

  /// The height of the ticket.
  ///
  /// For horizontal tickets, this sets the fixed height.
  /// For vertical tickets, this is optional as the height is determined by content.
  final double? height;

  /// The decoration properties for the ticket.
  ///
  /// This includes properties like border radius, background color,
  /// border style, and divider style.
  final TicketcherDecoration decoration;

  /// Whether the ticket should be rendered horizontally.
  ///
  /// If true, the ticket will be rendered using [HTicketcher].
  /// If false, the ticket will be rendered using [VTicketcher].
  final bool isHorizontal;

  /// Creates a new [Ticketcher].
  ///
  /// The [sections] parameter must contain at least 2 sections.
  /// The [notchRadius] defaults to 10.0.
  /// The [width] and [height] are optional.
  /// The [decoration] defaults to a basic [TicketcherDecoration].
  /// The [isHorizontal] flag determines the ticket orientation.
  const Ticketcher({
    super.key,
    required this.sections,
    this.notchRadius = 10.0,
    this.width,
    this.height,
    this.decoration = const TicketcherDecoration(),
    this.isHorizontal = false,
  }) : assert(sections.length >= 2, 'Ticketcher must have at least 2 sections');

  /// Creates a new vertical [Ticketcher].
  ///
  /// This is a convenience constructor that creates a vertical ticket
  /// with the specified parameters.
  const Ticketcher.vertical({
    Key? key,
    required List<Section> sections,
    double notchRadius = 10.0,
    double? width,
    TicketcherDecoration decoration = const TicketcherDecoration(),
  }) : this(
         key: key,
         sections: sections,
         notchRadius: notchRadius,
         width: width,
         decoration: decoration,
         isHorizontal: false,
       );

  /// Creates a new horizontal [Ticketcher].
  ///
  /// This is a convenience constructor that creates a horizontal ticket
  /// with the specified parameters.
  const Ticketcher.horizontal({
    Key? key,
    required List<Section> sections,
    double notchRadius = 10.0,
    double? width,
    double? height,
    TicketcherDecoration decoration = const TicketcherDecoration(),
  }) : this(
         key: key,
         sections: sections,
         notchRadius: notchRadius,
         width: width,
         height: height,
         decoration: decoration,
         isHorizontal: true,
       );

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return HTicketcher(
        sections: sections,
        notchRadius: notchRadius,
        height: height,
        decoration: decoration,
      );
    }
    return VTicketcher(
      sections: sections,
      notchRadius: notchRadius,
      width: width,
      decoration: decoration,
    );
  }
}
