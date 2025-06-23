import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/hticketcher_painter.dart';

/// A widget that creates a horizontal ticket with customizable sections, borders, and dividers.
///
/// The [HTicketcher] widget is used to create horizontal tickets with multiple sections,
/// each separated by notches and optional dividers. It supports various border styles,
/// corner rounding, and divider patterns. Sections can be sized using flex factors
/// to create proportional layouts.
///
/// Example:
/// ```dart
/// HTicketcher(
///   sections: [
///     Section(
///       child: Text('Left Section'),
///       padding: EdgeInsets.all(16),
///       widthFactor: 2.0, // Takes up twice the space of other sections
///     ),
///     Section(
///       child: Text('Right Section'),
///       padding: EdgeInsets.all(16),
///       widthFactor: 1.0, // Default flex factor
///     ),
///   ],
///   height: 200,
///   decoration: TicketcherDecoration(
///     borderRadius: TicketRadius.all(8.0),
///     backgroundColor: Colors.white,
///     border: Border.all(color: Colors.grey),
///     divider: TicketDivider.doubleLine(
///       color: Colors.grey,
///       thickness: 1.0,
///       lineSpacing: 4.0,
///     ),
///   ),
/// )
/// ```
class HTicketcher extends StatefulWidget {
  /// The list of sections to be displayed in the ticket.
  ///
  /// Each section represents a distinct part of the ticket with its own content,
  /// padding, and optional width factor. The sections are arranged horizontally
  /// in the order they appear in this list.
  final List<Section> sections;

  /// The radius of the notches between ticket sections.
  ///
  /// This determines how rounded the cutouts between sections will be.
  /// Defaults to 10.0.
  final double notchRadius;

  /// The height of the ticket.
  ///
  /// If null, the ticket will expand to fill the available height.
  final double? height;

  /// The decoration properties for the ticket.
  ///
  /// This includes properties like border radius, background color,
  /// border style, and divider style.
  final TicketcherDecoration decoration;

  /// Creates a new [HTicketcher].
  ///
  /// The [sections] parameter must contain at least 2 sections.
  /// The [notchRadius] defaults to 10.0.
  /// The [height] is optional and defaults to null.
  /// The [decoration] defaults to a basic [TicketcherDecoration].
  const HTicketcher({
    super.key,
    required this.sections,
    this.notchRadius = 10.0,
    this.height,
    this.decoration = const TicketcherDecoration(),
  }) : assert(
         sections.length >= 2,
         'HTicketcher must have at least 2 sections',
       );

  @override
  State<HTicketcher> createState() => _HTicketcherState();
}

/// The state for the [HTicketcher] widget.
///
/// This state class manages the width calculations for each section
/// and handles the layout of the ticket sections.
class _HTicketcherState extends State<HTicketcher> {
  /// Keys used to measure the width of each section.
  final List<GlobalKey> _sectionKeys = [];

  /// The calculated widths of each section.
  final List<double> _sectionWidths = [];

  @override
  void initState() {
    super.initState();
    // Initialize keys and widths for each section
    _sectionKeys.addAll(
      List.generate(widget.sections.length, (index) => GlobalKey()),
    );
    _sectionWidths.addAll(List.filled(widget.sections.length, 0));

    // Calculate section widths after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _sectionKeys.length; i++) {
        if (_sectionKeys[i].currentContext != null) {
          final RenderBox renderBox =
              _sectionKeys[i].currentContext!.findRenderObject() as RenderBox;
          setState(() {
            _sectionWidths[i] = renderBox.size.width;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return IntrinsicWidth(
            child: CustomPaint(
              painter: HTicketcherPainter(
                notchRadius: widget.notchRadius,
                decoration: widget.decoration,
                sectionWidths: _sectionWidths,
                sections: widget.sections,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.sections.length, (index) {
                  final section = widget.sections[index];
                  return Expanded(
                    flex: (section.widthFactor ?? 1.0).round(),
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
