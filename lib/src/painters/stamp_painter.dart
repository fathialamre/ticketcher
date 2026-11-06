import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/border_dash.dart';
import '../models/ticket_stamp.dart';
import 'path_dasher.dart';

final RegExp _arabicScript = RegExp(
  '[؀-ۿݐ-ݿࢠ-ࣿﭐ-﷿ﹰ-﻿]',
);

/// Measured text for a [TicketStamp]. Call [dispose] when done.
class _StampText {
  final TextPainter title;
  final TextPainter? subtitle;
  final double gap;

  _StampText(this.title, this.subtitle, this.gap);

  Size get size => Size(
        math.max(title.width, subtitle?.width ?? 0),
        title.height + (subtitle == null ? 0 : gap + subtitle!.height),
      );

  void dispose() {
    title.dispose();
    subtitle?.dispose();
  }

  static _StampText layout(
    TicketStamp stamp,
    TextDirection textDirection,
    TextScaler textScaler,
  ) {
    final bool arabic = _arabicScript.hasMatch(stamp.text) ||
        (stamp.subtitle != null && _arabicScript.hasMatch(stamp.subtitle!));

    final titleStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      height: 1.1,
      // Letter spacing breaks Arabic letter joining.
      letterSpacing: arabic ? 0 : 3,
      color: stamp.color,
    ).merge(stamp.textStyle);

    final title = TextPainter(
      text: TextSpan(text: stamp.text, style: titleStyle),
      textAlign: TextAlign.center,
      textDirection: textDirection,
      textScaler: textScaler,
    )..layout();

    TextPainter? subtitle;
    if (stamp.subtitle != null && stamp.subtitle!.isNotEmpty) {
      final subtitleStyle = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: arabic ? 0 : 2,
        color: stamp.color,
      ).merge(stamp.subtitleStyle);
      subtitle = TextPainter(
        text: TextSpan(text: stamp.subtitle, style: subtitleStyle),
        textAlign: TextAlign.center,
        textDirection: textDirection,
        textScaler: textScaler,
      )..layout();
    }

    return _StampText(title, subtitle, 2);
  }
}

/// Paints a [TicketStamp]: outline in its [StampShape] / [StampBorderStyle],
/// centered text, and the optional ink-texture speckle.
///
/// Size the [CustomPaint] with [TicketStampPainter.measure].
class TicketStampPainter extends CustomPainter {
  final TicketStamp stamp;
  final TextDirection textDirection;
  final TextScaler textScaler;

  TicketStampPainter({
    required this.stamp,
    required this.textDirection,
    this.textScaler = TextScaler.noScaling,
  });

  /// Natural (unrotated) size of [stamp] for the given text settings.
  static Size measure(
    TicketStamp stamp, {
    required TextDirection textDirection,
    TextScaler textScaler = TextScaler.noScaling,
  }) {
    final text = _StampText.layout(stamp, textDirection, textScaler);
    final size = _shapeSize(stamp, text.size);
    text.dispose();
    return size;
  }

  /// Width of the band the outline occupies on each side.
  static double _outlineExtent(TicketStamp stamp) =>
      stamp.borderStyle == StampBorderStyle.double
          ? stamp.borderWidth * 3
          : stamp.borderWidth;

  static double _sealAmplitude(double radius) => math.min(radius * 0.06, 4);

  static Size _shapeSize(TicketStamp stamp, Size content) {
    final extent = _outlineExtent(stamp);
    final w = content.width + stamp.padding.horizontal + extent * 2;
    final h = content.height + stamp.padding.vertical + extent * 2;

    switch (stamp.shape) {
      case StampShape.rectangle:
      case StampShape.roundedRectangle:
        return Size(w, h);
      case StampShape.circle:
        final d = math.sqrt(w * w + h * h);
        return Size.square(d);
      case StampShape.seal:
        final d = math.sqrt(w * w + h * h);
        return Size.square(d + _sealAmplitude(d / 2) * 4);
      case StampShape.oval:
        return Size(w * math.sqrt2, h * math.sqrt2);
      case StampShape.hexagon:
      case StampShape.ribbon:
        return Size(w + h, h);
    }
  }

  /// Outline path of [shape] fitted inside [rect].
  static Path _shapePath(StampShape shape, Rect rect) {
    final w = rect.width;
    final h = rect.height;
    switch (shape) {
      case StampShape.rectangle:
        return Path()..addRect(rect);
      case StampShape.roundedRectangle:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(
            rect,
            Radius.circular(math.min(h * 0.25, 12)),
          ));
      case StampShape.circle:
      case StampShape.oval:
        return Path()..addOval(rect);
      case StampShape.seal:
        final center = rect.center;
        final radius = math.min(w, h) / 2;
        final amplitude = _sealAmplitude(radius);
        final waves = math.max(12, (radius / 4).round());
        const steps = 360;
        final path = Path();
        for (int i = 0; i <= steps; i++) {
          final t = i / steps * 2 * math.pi;
          final r = radius - amplitude + amplitude * math.cos(waves * t);
          final p = center + Offset(math.cos(t) * r, math.sin(t) * r);
          if (i == 0) {
            path.moveTo(p.dx, p.dy);
          } else {
            path.lineTo(p.dx, p.dy);
          }
        }
        return path..close();
      case StampShape.hexagon:
        final tip = math.min(h / 2, w / 2);
        return Path()
          ..moveTo(rect.left, rect.top + h / 2)
          ..lineTo(rect.left + tip, rect.top)
          ..lineTo(rect.right - tip, rect.top)
          ..lineTo(rect.right, rect.top + h / 2)
          ..lineTo(rect.right - tip, rect.bottom)
          ..lineTo(rect.left + tip, rect.bottom)
          ..close();
      case StampShape.ribbon:
        final notch = math.min(h / 3, w / 4);
        return Path()
          ..moveTo(rect.left, rect.top)
          ..lineTo(rect.right, rect.top)
          ..lineTo(rect.right - notch, rect.top + h / 2)
          ..lineTo(rect.right, rect.bottom)
          ..lineTo(rect.left, rect.bottom)
          ..lineTo(rect.left + notch, rect.top + h / 2)
          ..close();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final bounds = Offset.zero & size;
    final bw = stamp.borderWidth;

    canvas.saveLayer(bounds, Paint());

    final stroke = Paint()
      ..color = stamp.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = bw
      ..strokeJoin = StrokeJoin.round;

    final outer = _shapePath(stamp.shape, bounds.deflate(bw / 2));
    switch (stamp.borderStyle) {
      case StampBorderStyle.single:
        canvas.drawPath(outer, stroke);
      case StampBorderStyle.dashed:
        canvas.drawPath(
          dashPath(outer, BorderDash(dash: bw * 3, gap: bw * 2)),
          stroke..strokeCap = StrokeCap.round,
        );
      case StampBorderStyle.double:
        canvas.drawPath(outer, stroke);
        // A seal's inner ring is a plain circle.
        final innerShape =
            stamp.shape == StampShape.seal ? StampShape.circle : stamp.shape;
        final innerInset = stamp.shape == StampShape.seal
            ? _sealAmplitude(size.shortestSide / 2) * 2 + bw * 2.5
            : bw * 2.5;
        canvas.drawPath(
          _shapePath(innerShape, bounds.deflate(innerInset)),
          stroke..strokeWidth = bw * 0.6,
        );
    }

    final text = _StampText.layout(stamp, textDirection, textScaler);
    final textSize = text.size;
    final top = (size.height - textSize.height) / 2;
    text.title.paint(
      canvas,
      Offset((size.width - text.title.width) / 2, top),
    );
    final subtitle = text.subtitle;
    if (subtitle != null) {
      subtitle.paint(
        canvas,
        Offset(
          (size.width - subtitle.width) / 2,
          top + text.title.height + text.gap,
        ),
      );
    }
    text.dispose();

    if (stamp.inkTexture) {
      final random = math.Random(stamp.inkSeed);
      final speckle = Paint()..blendMode = BlendMode.dstOut;
      final count = (size.width * size.height / 70).clamp(30, 500).round();
      for (int i = 0; i < count; i++) {
        speckle.color = Color.fromRGBO(0, 0, 0, 0.35 + random.nextDouble() * 0.65);
        canvas.drawCircle(
          Offset(
            random.nextDouble() * size.width,
            random.nextDouble() * size.height,
          ),
          0.4 + random.nextDouble() * 1.1,
          speckle,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(TicketStampPainter oldDelegate) =>
      oldDelegate.stamp != stamp ||
      oldDelegate.textDirection != textDirection ||
      oldDelegate.textScaler != textScaler;
}
