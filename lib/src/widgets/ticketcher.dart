import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/ticketcher_painter.dart';

class Ticketcher extends StatefulWidget {
  final List<Section> sections;
  final double notchRadius;
  final double? width;
  final TicketcherDecoration decoration;

  const Ticketcher({
    super.key,
    required this.sections,
    this.notchRadius = 10.0,
    this.width,
    this.decoration = const TicketcherDecoration(),
  }) : assert(sections.length >= 2, 'Ticketcher must have at least 2 sections');

  @override
  State<Ticketcher> createState() => _TicketcherState();
}

class _TicketcherState extends State<Ticketcher> {
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
                sectionHeights: _sectionHeights,
                decoration: widget.decoration,
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
