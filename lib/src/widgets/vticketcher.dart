import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../painters/vticketcher_painter.dart';

/// A widget that creates a vertical ticket with customizable sections, borders, and dividers.
///
/// The [VTicketcher] widget is used to create vertical tickets with multiple sections,
/// each separated by notches and optional dividers. It supports various border styles,
/// corner rounding, and divider patterns.
///
/// Example:
/// ```dart
/// VTicketcher(
///   sections: [
///     Section(
///       child: Text('Header Section'),
///       padding: EdgeInsets.all(16),
///     ),
///     Section(
///       child: Text('Content Section'),
///       padding: EdgeInsets.all(16),
///     ),
///   ],
///   notchRadius: 10.0,
///   width: 300,
///   decoration: TicketcherDecoration(
///     borderRadius: TicketRadius.all(8.0),
///     backgroundColor: Colors.white,
///     border: Border.all(color: Colors.grey),
///     divider: TicketDivider.dotted(
///       color: Colors.grey,
///       thickness: 1.0,
///       dotSize: 4.0,
///       dotSpacing: 8.0,
///     ),
///   ),
/// )
/// ```
class VTicketcher extends StatefulWidget {
  /// The list of sections to be displayed in the ticket.
  ///
  /// Each section represents a distinct part of the ticket with its own content
  /// and padding. The sections are stacked vertically in the order they appear
  /// in this list.
  final List<Section> sections;

  /// The radius of the notches between ticket sections.
  ///
  /// This determines how rounded the cutouts between sections will be.
  /// Defaults to 10.0.
  final double notchRadius;

  /// The width of the ticket.
  ///
  /// If null, the ticket will expand to fill the available width.
  final double? width;

  /// The decoration properties for the ticket.
  ///
  /// This includes properties like border radius, background color,
  /// border style, and divider style.
  final TicketcherDecoration decoration;

  /// Creates a new [VTicketcher].
  ///
  /// The [sections] parameter must contain at least 2 sections.
  /// The [notchRadius] defaults to 10.0.
  /// The [width] is optional and defaults to null.
  /// The [decoration] defaults to a basic [TicketcherDecoration].
  VTicketcher({
    super.key,
    required this.sections,
    this.notchRadius = 10.0,
    this.width,
    this.decoration = const TicketcherDecoration(),
  }) : assert(
         sections.length >= 2,
         'Vertical Ticketcher must have at least 2 sections',
       ) {
    assert(
      decoration.bottomBorderStyle == null ||
          !(decoration.borderRadius.corner == TicketCorner.bottom ||
              decoration.borderRadius.corner == TicketCorner.bottomLeft ||
              decoration.borderRadius.corner == TicketCorner.bottomRight ||
              decoration.borderRadius.corner == TicketCorner.all),
      'Cannot use bottomBorderStyle when there is a bottom border radius',
    );
  }

  @override
  State<VTicketcher> createState() => _VTicketcherState();
}

/// The state for the [VTicketcher] widget.
///
/// This state class manages the height calculations for each section
/// and handles the layout of the ticket sections.
class _VTicketcherState extends State<VTicketcher> {
  /// Keys used to measure the height of each section.
  final List<GlobalKey> _sectionKeys = [];

  /// The calculated heights of each section.
  final List<double> _sectionHeights = [];

  @override
  void initState() {
    super.initState();
    // Initialize keys and heights for each section
    _sectionKeys.addAll(
      List.generate(widget.sections.length, (index) => GlobalKey()),
    );
    _sectionHeights.addAll(List.filled(widget.sections.length, 0));

    // Calculate section heights after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _sectionKeys.length; i++) {
        if (_sectionKeys[i].currentContext != null) {
          final RenderBox renderBox =
              _sectionKeys[i].currentContext!.findRenderObject() as RenderBox;
          setState(() {
            _sectionHeights[i] = renderBox.size.height;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return IntrinsicHeight(
            child: CustomPaint(
              painter: VTicketcherPainter(
                notchRadius: widget.notchRadius,
                decoration: widget.decoration,
                sectionHeights: _sectionHeights,
                sections: widget.sections,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.sections.length, (index) {
                  final section = widget.sections[index];
                  return GestureDetector(
                    onTap: section.onTap,
                    child: Container(
                      key: _sectionKeys[index],
                      padding: section.padding,
                      child: section.child,
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
