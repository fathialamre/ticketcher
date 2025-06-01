import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/hticketcher_painter.dart';

class HTicketcher extends StatefulWidget {
  final List<Section> sections;
  final double notchRadius;
  final double? height;
  final TicketcherDecoration decoration;

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

class _HTicketcherState extends State<HTicketcher> {
  final List<GlobalKey> _sectionKeys = [];
  final List<double> _sectionWidths = [];

  @override
  void initState() {
    super.initState();
    _sectionKeys.addAll(
      List.generate(widget.sections.length, (index) => GlobalKey()),
    );
    _sectionWidths.addAll(List.filled(widget.sections.length, 0));

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
