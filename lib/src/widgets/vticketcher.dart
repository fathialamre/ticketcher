import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../models/ticket_watermark.dart';
import '../painters/vticketcher_painter.dart';
import 'blur_wrapper.dart';

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
          final ticketWidget = BlurWrapper(
            blurEffect: widget.decoration.blurEffect,
            notchRadius: widget.notchRadius,
            decoration: widget.decoration,
            sectionMeasurements: _sectionHeights,
            isVertical: true,
            child: IntrinsicHeight(
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
            ),
          );

          // Build with overlays (watermark)
          return _buildWithOverlays(ticketWidget);
        },
      ),
    );
  }

  /// Builds the ticket with all overlays (watermark)
  Widget _buildWithOverlays(Widget ticketWidget) {
    final hasWidgetWatermark =
        widget.decoration.watermark?.type == WatermarkType.widget &&
        widget.decoration.watermark?.widget != null;

    if (!hasWidgetWatermark) {
      return ticketWidget;
    }

    return Stack(
      children: [
        ticketWidget,
        if (hasWidgetWatermark)
          _buildWidgetWatermarkOverlay(widget.decoration.watermark!),
      ],
    );
  }

  /// Builds the widget watermark overlay
  ///
  /// Note: Widget watermarks do not support repeat functionality.
  /// Only text watermarks support repeating patterns.
  Widget _buildWidgetWatermarkOverlay(TicketWatermark watermark) {
    Widget watermarkWidget = watermark.widget!;

    // Apply size constraints if specified
    if (watermark.width != null || watermark.height != null) {
      watermarkWidget = SizedBox(
        width: watermark.width,
        height: watermark.height,
        child: watermarkWidget,
      );
    }

    // Apply opacity
    watermarkWidget = Opacity(
      opacity: watermark.opacity,
      child: watermarkWidget,
    );

    // Apply rotation if specified
    if (watermark.rotation != 0) {
      watermarkWidget = Transform.rotate(
        angle: watermark.rotation * 3.14159 / 180, // Convert degrees to radians
        child: watermarkWidget,
      );
    }

    // Apply offset
    if (watermark.offset != Offset.zero) {
      watermarkWidget = Transform.translate(
        offset: watermark.offset,
        child: watermarkWidget,
      );
    }

    // Apply alignment and create positioned widget
    return Positioned.fill(
      child: Align(
        alignment: watermark.flutterAlignment,
        child: watermarkWidget,
      ),
    );
  }
}
