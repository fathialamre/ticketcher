import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../models/ticket_radius.dart';
import '../painters/ticketcher_painter.dart';
import 'hticketcher.dart';

class VTicketcher extends StatefulWidget {
  final List<Section> sections;
  final double notchRadius;
  final double? width;
  final TicketcherDecoration decoration;

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

class _VTicketcherState extends State<VTicketcher> {
  final List<GlobalKey> _sectionKeys = [];
  final List<double> _sectionHeights = [];

  @override
  void initState() {
    super.initState();
    _sectionKeys.addAll(
      List.generate(widget.sections.length, (index) => GlobalKey()),
    );
    _sectionHeights.addAll(List.filled(widget.sections.length, 0));

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
              painter: TicketcherPainter(
                notchRadius: widget.notchRadius,
                decoration: widget.decoration,
                sectionHeights: _sectionHeights,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.sections.length,
                  (index) => Container(
                    key: _sectionKeys[index],
                    padding: widget.sections[index].padding,
                    child: widget.sections[index].child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Ticketcher extends StatelessWidget {
  final List<Section> sections;
  final double notchRadius;
  final double? width;
  final double? height;
  final TicketcherDecoration decoration;
  final bool isHorizontal;

  const Ticketcher({
    super.key,
    required this.sections,
    this.notchRadius = 10.0,
    this.width,
    this.height,
    this.decoration = const TicketcherDecoration(),
    this.isHorizontal = false,
  }) : assert(sections.length >= 2, 'Ticketcher must have at least 2 sections');

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
