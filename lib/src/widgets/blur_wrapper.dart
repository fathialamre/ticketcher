import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/blur_effect.dart';
import '../models/ticketcher_decoration.dart';
import 'ticket_clipper.dart';

/// A widget that wraps its child with a blur effect
///
/// Supports different blur styles including backdrop filter,
/// frosted glass, and gaussian blur effects. The blur can be clipped
/// to match the ticket shape with rounded corners and notches.
class BlurWrapper extends StatelessWidget {
  final Widget child;
  final BlurEffect? blurEffect;
  final double? notchRadius;
  final TicketcherDecoration? decoration;
  final List<double>? sectionMeasurements;
  final bool? isVertical;

  const BlurWrapper({
    super.key,
    required this.child,
    this.blurEffect,
    this.notchRadius,
    this.decoration,
    this.sectionMeasurements,
    this.isVertical,
  });

  @override
  Widget build(BuildContext context) {
    // No blur effect, return child as-is
    if (blurEffect == null) {
      return child;
    }

    switch (blurEffect!.style) {
      case BlurStyle.backdrop:
        return _buildBackdropBlur();
      case BlurStyle.frosted:
        return _buildFrostedGlass();
      case BlurStyle.gaussian:
        return _buildGaussianBlur();
    }
  }

  Widget _buildBackdropBlur() {
    return _wrapWithClipper(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurEffect!.sigma,
          sigmaY: blurEffect!.sigma,
        ),
        child: child,
      ),
    );
  }

  Widget _buildFrostedGlass() {
    final tintColor = blurEffect!.tintColor ?? Colors.white;

    return _wrapWithClipper(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurEffect!.sigma,
          sigmaY: blurEffect!.sigma,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: tintColor.withOpacity(blurEffect!.opacity),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildGaussianBlur() {
    return _wrapWithClipper(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: blurEffect!.sigma,
          sigmaY: blurEffect!.sigma,
        ),
        child: child,
      ),
    );
  }

  /// Wraps the child with a custom clipper if clipping parameters are provided
  Widget _wrapWithClipper({required Widget child}) {
    // If we don't have all the parameters needed for custom clipping, use ClipRect
    if (notchRadius == null ||
        decoration == null ||
        sectionMeasurements == null ||
        isVertical == null ||
        sectionMeasurements!.isEmpty) {
      return ClipRect(child: child);
    }

    // Use custom clipper based on orientation
    if (isVertical!) {
      return ClipPath(
        clipper: VTicketcherClipper(
          notchRadius: notchRadius!,
          decoration: decoration!,
          sectionHeights: sectionMeasurements!,
        ),
        child: child,
      );
    } else {
      return ClipPath(
        clipper: HTicketcherClipper(
          notchRadius: notchRadius!,
          decoration: decoration!,
          sectionWidths: sectionMeasurements!,
        ),
        child: child,
      );
    }
  }
}
