import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_watermark.dart';
import '../painters/hticketcher_painter.dart';
import '../painters/image_resolver.dart';
import 'blur_wrapper.dart';

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
   final VoidCallback? onTap;

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
    this.onTap,
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

  /// Image resolver for loading and caching images
  final ImageResolver _imageResolver = ImageResolver();

  /// Resolved decoration background image
  ui.Image? _decorationBackgroundImage;

  /// Resolved section background images
  final Map<int, ui.Image> _sectionBackgroundImages = {};

  @override
  void initState() {
    super.initState();
    // Initialize keys and widths for each section
    _sectionKeys.addAll(
      List.generate(widget.sections.length, (index) => GlobalKey()),
    );
    _sectionWidths.addAll(List.filled(widget.sections.length, 0));

    // Load images and calculate section widths after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load images
      _loadImages();

      // Calculate section widths
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
  void didUpdateWidget(HTicketcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle section count changes
    if (oldWidget.sections.length != widget.sections.length) {
      _updateSectionKeysAndWidths();
    }

    // Reload images if they changed
    bool needsReload = false;

    if (oldWidget.decoration.backgroundImage !=
        widget.decoration.backgroundImage) {
      needsReload = true;
    }

    if (oldWidget.sections.length != widget.sections.length) {
      needsReload = true;
    } else {
      for (int i = 0; i < widget.sections.length; i++) {
        if (oldWidget.sections[i].backgroundImage !=
            widget.sections[i].backgroundImage) {
          needsReload = true;
          break;
        }
      }
    }

    if (needsReload) {
      _loadImages();
    }
  }

  /// Updates section keys and widths when section count changes.
  void _updateSectionKeysAndWidths() {
    final newCount = widget.sections.length;
    final oldCount = _sectionKeys.length;

    if (newCount > oldCount) {
      // Add new keys and widths
      for (int i = oldCount; i < newCount; i++) {
        _sectionKeys.add(GlobalKey());
        _sectionWidths.add(0);
      }
    } else if (newCount < oldCount) {
      // Remove excess keys and widths
      _sectionKeys.removeRange(newCount, oldCount);
      _sectionWidths.removeRange(newCount, oldCount);
    }

    // Recalculate widths after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _sectionKeys.length; i++) {
        if (_sectionKeys[i].currentContext != null) {
          final RenderBox renderBox =
              _sectionKeys[i].currentContext!.findRenderObject() as RenderBox;
          if (mounted) {
            setState(() {
              _sectionWidths[i] = renderBox.size.width;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _imageResolver.dispose();
    super.dispose();
  }

  /// Loads all images (decoration and section backgrounds)
  Future<void> _loadImages() async {
    // Load decoration background image
    if (widget.decoration.backgroundImage != null) {
      final image = await _imageResolver.resolveImage(
        widget.decoration.backgroundImage!,
        configuration: ImageConfiguration.empty,
      );
      if (mounted) {
        setState(() {
          _decorationBackgroundImage = image;
        });
      }
    } else {
      _decorationBackgroundImage = null;
    }

    // Load section background images
    _sectionBackgroundImages.clear();
    for (int i = 0; i < widget.sections.length; i++) {
      final section = widget.sections[i];
      if (section.backgroundImage != null) {
        final image = await _imageResolver.resolveImage(
          section.backgroundImage!,
          configuration: ImageConfiguration.empty,
        );
        if (mounted && image != null) {
          setState(() {
            _sectionBackgroundImages[i] = image;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final ticketWidget = BlurWrapper(
              blurEffect: widget.decoration.blurEffect,
              notchRadius: widget.notchRadius,
              decoration: widget.decoration,
              sectionMeasurements: _sectionWidths,
              isVertical: false,
              child: IntrinsicWidth(
                child: CustomPaint(
                  painter: HTicketcherPainter(
                    notchRadius: widget.notchRadius,
                    decoration: widget.decoration,
                    sectionWidths: _sectionWidths,
                    sections: widget.sections,
                    decorationBackgroundImage: _decorationBackgroundImage,
                    sectionBackgroundImages: _sectionBackgroundImages,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.sections.length, (index) {
                      final section = widget.sections[index];
                      return Expanded(
                        flex: (section.widthFactor ?? 1.0).round(),
                        child: GestureDetector(
                          onTap: section.onTap,
                          child: Container(
                            key: _sectionKeys[index],
                            padding: section.padding,
                            child: section.child,
                          ),
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
        angle: watermark.rotation * math.pi / 180, // Convert degrees to radians
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
