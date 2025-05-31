import 'package:flutter/material.dart';
import '../models/section.dart';
import '../models/ticketcher_decoration.dart';
import '../painters/ticketcher_painter.dart';

class Ticketcher extends StatefulWidget {
  final Section primarySection;
  final Section secondarySection;
  final double notchRadius;
  final double? width;
  final TicketcherDecoration decoration;

  const Ticketcher({
    super.key,
    required this.primarySection,
    required this.secondarySection,
    this.notchRadius = 10.0,
    this.width,
    this.decoration = const TicketcherDecoration(),
  });

  @override
  State<Ticketcher> createState() => _TicketcherState();
}

class _TicketcherState extends State<Ticketcher> {
  final GlobalKey _primaryKey = GlobalKey();
  double _primaryHeight = 0;

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
                primaryHeight: _primaryHeight,
                decoration: widget.decoration,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    key: _primaryKey,
                    padding: widget.primarySection.padding,
                    child: widget.primarySection.child,
                  ),
                  Container(
                    padding: widget.secondarySection.padding,
                    child: widget.secondarySection.child,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_primaryKey.currentContext != null) {
        final RenderBox renderBox =
            _primaryKey.currentContext!.findRenderObject() as RenderBox;
        setState(() {
          _primaryHeight = renderBox.size.height;
        });
      }
    });
  }
}
