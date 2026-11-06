// README screenshot board.
//
// Each page is one feature composed in a fixed 402 × 500 frame (4:5) on the
// Gallery Mono backdrop. Run on an iPhone 16 Pro simulator, swipe through the
// pages and capture each one:
//
//   flutter run -t lib/readme_shots.dart
//   xcrun simctl io booted screenshot shot.png
//
// then crop the frame (see tool/crop_shots.sh).
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import 'theme/gallery_mono.dart';

void main() => runApp(const ReadmeShotsApp());

class ReadmeShotsApp extends StatelessWidget {
  const ReadmeShotsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: galleryMonoTheme(),
      home: const _ShotPager(),
    );
  }
}

/// Frame size, in logical pixels, of every screenshot.
const Size kShotSize = Size(402, 500);

/// With `--dart-define=AUTOPLAY=true` the pager waits [_autoplayLead], then
/// shows each shot for [_autoplayStep] so a script can capture them in turn.
const bool _autoplay = bool.fromEnvironment('AUTOPLAY');
const Duration _autoplayLead = Duration(seconds: 6);
const Duration _autoplayStep = Duration(seconds: 3);

class _ShotPager extends StatefulWidget {
  const _ShotPager();

  @override
  State<_ShotPager> createState() => _ShotPagerState();
}

class _ShotPagerState extends State<_ShotPager> {
  final _controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (_autoplay) {
      _timer = Timer(_autoplayLead, () {
        _timer = Timer.periodic(_autoplayStep, (_) {
          final next = (_controller.page?.round() ?? 0) + 1;
          _controller.jumpToPage(next);
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final image in _ImageShot.images) {
      precacheImage(image, context);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shots = <Widget>[
      const _CoverShot(),
      const _FlipShot(),
      const _StampShot(),
      const _RtlShot(),
      const _ExpiredShot(),
      const _NotchShot(),
      const _DividerShot(),
      const _EdgeShot(),
      const _GradientShot(),
      const _GradientBorderShot(),
      const _ImageShot(),
      const _ColoredSectionsShot(),
      const _GlassShot(),
      const _WatermarkShot(),
      const _StitchShot(),
      const _StackShot(),
      const _PunchShadowShot(),
      const _BoardingPassShot(),
    ];
    return Scaffold(
      backgroundColor: Mono.panel,
      body: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
            size: kShotSize,
            child: PageView(controller: _controller, children: shots),
          ),
        ),
      ),
    );
  }
}

/// Common frame: eyebrow + headline on top, the feature centered below.
class _Shot extends StatelessWidget {
  const _Shot({
    required this.eyebrow,
    required this.title,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Mono.panel,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 26, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Mono.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(eyebrow.toUpperCase(), style: Mono.eyebrow),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                height: 1.15,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                color: Mono.ink,
              ),
            ),
            Expanded(child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared ticket content
// ---------------------------------------------------------------------------

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text, {this.color = Mono.ash});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Mono.eyebrow.copyWith(color: color, fontSize: 10));
}

class _Big extends StatelessWidget {
  const _Big(this.text, {this.color = Mono.ink, this.size = 24});
  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: 1.05,
      color: color,
    ),
  );
}

/// Label/value pair used in ticket stubs.
class _Field extends StatelessWidget {
  const _Field(this.label, this.value, {this.dark = false, this.end = false});
  final String label;
  final String value;
  final bool dark;
  final bool end;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _Eyebrow(label, color: dark ? Mono.onDarkMuted : Mono.ash),
      const SizedBox(height: 2),
      _Big(value, size: 17, color: dark ? Mono.onDark : Mono.ink),
    ],
  );
}

List<Section> _trainSections({
  bool dark = false,
  String route = 'BEN → TIP',
  String kind = 'TRAIN · 2ND CLASS',
  Color? label,
}) {
  final ink = dark ? Mono.onDark : Mono.ink;
  return [
    Section(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 108,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(kind, color: label ?? (dark ? Mono.blueLight : Mono.ash)),
            const SizedBox(height: 8),
            _Big(route, color: ink, size: 28),
            const Spacer(),
            Text(
              'SAT 21 NOV · 08:40',
              style: TextStyle(
                fontSize: 12,
                color: dark ? Mono.onDarkMuted : Mono.ash,
              ),
            ),
          ],
        ),
      ),
    ),
    Section(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Field('SEAT', 'C·07', dark: dark),
          _Field('COACH', '04', dark: dark),
          _Field('GATE', 'B', dark: dark, end: true),
        ],
      ),
    ),
  ];
}

/// Compact horizontal strip ticket: big code on the left, stub on the right.
Widget _strip({
  required String eyebrow,
  required String code,
  required TicketcherDecoration decoration,
  bool dark = false,
  double height = 74,
  double width = 300,
}) {
  final ink = dark ? Mono.onDark : Mono.ink;
  final muted = dark ? Mono.onDarkMuted : Mono.ash;
  return SizedBox(
    width: width,
    child: Ticketcher.horizontal(
      height: height,
      decoration: decoration,
      sections: [
        Section(
          widthFactor: 3,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Eyebrow(eyebrow, color: muted),
              const SizedBox(height: 4),
              _Big(code, color: ink, size: 20),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(8),
          child: Center(child: Icon(Icons.qr_code_2, size: 34, color: ink)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shots
// ---------------------------------------------------------------------------

class _CoverShot extends StatelessWidget {
  const _CoverShot();

  @override
  Widget build(BuildContext context) {
    Widget card(Widget ticket, double angle, Offset offset) =>
        Transform.translate(
          offset: offset,
          child: Transform.rotate(angle: angle * math.pi / 180, child: ticket),
        );

    return _Shot(
      eyebrow: 'Ticketcher',
      title: 'Tickets, passes and\ncoupons for Flutter.',
      child: SizedBox(
        width: 340,
        height: 330,
        child: Stack(
          alignment: Alignment.center,
          children: [
            card(
              VTicketcher(
                width: 190,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.blue,
                  borderRadius: const TicketRadius(radius: 16),
                  divider: TicketDivider.dashed(color: Mono.blueLight),
                ),
                sections: _trainSections(
                  dark: true,
                  route: 'LIVE',
                  kind: 'CONCERT · PIT',
                  label: Mono.blueSoft,
                ),
              ),
              -14,
              const Offset(-78, 10),
            ),
            card(
              VTicketcher(
                width: 190,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.black,
                  borderRadius: const TicketRadius(radius: 16),
                  divider: TicketDivider.dashed(color: Mono.graphite),
                ),
                sections: _trainSections(
                  dark: true,
                  route: 'IST → TIP',
                  kind: 'FLIGHT · TK 1964',
                ),
              ),
              10,
              const Offset(78, 14),
            ),
            card(
              VTicketcher(
                width: 200,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.white,
                  borderRadius: const TicketRadius(radius: 16),
                  divider: TicketDivider.dashed(color: Mono.line),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                  stamp: const TicketStamp.used(
                    color: Mono.blue,
                    alignment: Alignment(0.42, -0.12),
                  ),
                ),
                sections: _trainSections(),
              ),
              -2,
              Offset.zero,
            ),
          ],
        ),
      ),
    );
  }
}

class _FlipShot extends StatelessWidget {
  const _FlipShot();

  Widget _front() => VTicketcher(
    width: 160,
    decoration: TicketcherDecoration(
      backgroundColor: Mono.black,
      borderRadius: const TicketRadius(radius: 16),
      divider: TicketDivider.dashed(color: Mono.graphite),
    ),
    sections: const [
      Section(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Eyebrow('MUSEUM PASS', color: Mono.blueLight),
              SizedBox(height: 8),
              _Big('National\nMuseum', color: Mono.onDark, size: 22),
              Spacer(),
              Text(
                'SAT 21 NOV',
                style: TextStyle(fontSize: 11, color: Mono.onDarkMuted),
              ),
            ],
          ),
        ),
      ),
      Section(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _Big('2 ADULTS', color: Mono.onDark, size: 17),
          ),
        ),
      ),
    ],
  );

  Widget _back() => VTicketcher(
    width: 160,
    decoration: TicketcherDecoration(
      backgroundColor: Mono.white,
      borderRadius: const TicketRadius(radius: 16),
      divider: TicketDivider.dashed(color: Mono.line),
    ),
    sections: const [
      Section(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Center(
            child: Icon(Icons.qr_code_2, size: 128, color: Mono.ink),
          ),
        ),
      ),
      Section(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: Text(
              'Show at the gate',
              style: TextStyle(fontSize: 12, color: Mono.ash),
            ),
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // The left ticket is caught mid-turn with the same perspective
    // FlipTicketcher uses; the right one is the settled back face.
    final midTurn = Matrix4.identity()
      ..setEntry(3, 2, 0.0015)
      ..rotateY(-0.62);
    return _Shot(
      eyebrow: 'FlipTicketcher · new in 2.3',
      title: 'Two faces.\nTap or swipe to flip.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: midTurn,
            child: _front(),
          ),
          const SizedBox(width: 14),
          _back(),
        ],
      ),
    );
  }
}

class _StampShot extends StatelessWidget {
  const _StampShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'TicketStamp · new in 2.3',
      title: 'Ink stamps in\nseven shapes.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VTicketcher(
            width: 300,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.white,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.line),
              stamp: const TicketStamp.used(
                color: Mono.blue,
                alignment: Alignment(0.5, -0.12),
              ),
            ),
            sections: _trainSections(),
          ),
          const SizedBox(height: 22),
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TicketStampMark(
                  stamp: TicketStamp.paid(color: Mono.blue, rotation: 0),
                ),
                SizedBox(width: 10),
                TicketStampMark(
                  stamp: TicketStamp(
                    text: 'VIP',
                    shape: StampShape.seal,
                    borderStyle: StampBorderStyle.single,
                    color: Mono.black,
                    rotation: 0,
                  ),
                ),
                SizedBox(width: 10),
                TicketStampMark(
                  stamp: TicketStamp(
                    text: 'GATE B',
                    shape: StampShape.ribbon,
                    color: Mono.blue,
                    rotation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RtlShot extends StatelessWidget {
  const _RtlShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'RTL & Arabic',
      title: 'Right-to-left,\nstamps included.',
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: VTicketcher(
          width: 320,
          decoration: TicketcherDecoration(
            backgroundColor: Mono.white,
            borderRadius: const TicketRadius(radius: 16),
            divider: TicketDivider.dashed(color: Mono.line),
            stamp: const TicketStamp(
              text: 'مُستخدَمة',
              subtitle: '١٤ ديسمبر',
              shape: StampShape.seal,
              borderStyle: StampBorderStyle.single,
              color: Mono.blue,
              rotation: -12,
              alignment: Alignment(-0.82, -0.32),
              textStyle: TextStyle(fontSize: 16),
              subtitleStyle: TextStyle(fontSize: 10),
            ),
          ),
          sections: const [
            Section(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 112,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الدخول العام',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Mono.blue,
                      ),
                    ),
                    SizedBox(height: 6),
                    _Big('معرض الكتاب', size: 28),
                  ],
                ),
              ),
            ),
            Section(
              padding: EdgeInsets.fromLTRB(20, 14, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Field('القاعة', '٣'),
                  _Field('المقعد', '٠٤٢'),
                  _Field('اليوم', 'السبت', end: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpiredShot extends StatelessWidget {
  const _ExpiredShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'TicketStatus.expired',
      title: 'Expired tickets fade;\nthe stamp stays sharp.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.blue,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.blueLight),
            ),
            sections: _miniSections('DAY 1', dark: true),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.blue,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.blueLight),
              status: TicketStatus.expired,
              stamp: const TicketStamp.voided(
                text: 'EXPIRED',
                color: Mono.black,
              ),
            ),
            sections: _miniSections('DAY 2', dark: true),
          ),
        ],
      ),
    );
  }

  static List<Section> _miniSections(String day, {bool dark = false}) => [
    Section(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Eyebrow('FESTIVAL', color: Mono.blueSoft),
            const SizedBox(height: 6),
            const _Big('OPEN\nAIR', color: Mono.onDark, size: 26),
            const Spacer(),
            Text(
              day,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Mono.blueSoft,
              ),
            ),
          ],
        ),
      ),
    ),
    const Section(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 44,
        child: Center(
          child: Icon(Icons.qr_code_2, size: 40, color: Mono.onDark),
        ),
      ),
    ),
  ];
}

class _NotchShot extends StatelessWidget {
  const _NotchShot();

  @override
  Widget build(BuildContext context) {
    TicketcherDecoration deco(NotchStyle notch, Color bg, Color line) =>
        TicketcherDecoration(
          backgroundColor: bg,
          notchStyle: notch,
          borderRadius: const TicketRadius(radius: 12),
          divider: TicketDivider.dashed(color: line),
        );
    return _Shot(
      eyebrow: 'NotchStyle',
      title: 'Four notch shapes.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _strip(
            eyebrow: 'SEMICIRCLE',
            code: 'NS-01',
            decoration: deco(
              const NotchStyle.semicircle(radius: 12),
              Mono.white,
              Mono.line,
            ),
          ),
          const SizedBox(height: 12),
          _strip(
            eyebrow: 'TRIANGLE',
            code: 'NS-02',
            dark: true,
            decoration: deco(
              const NotchStyle.triangle(radius: 12),
              Mono.black,
              Mono.graphite,
            ),
          ),
          const SizedBox(height: 12),
          _strip(
            eyebrow: 'SQUARE',
            code: 'NS-03',
            dark: true,
            decoration: deco(
              const NotchStyle.square(radius: 11),
              Mono.blue,
              Mono.blueLight,
            ),
          ),
          const SizedBox(height: 12),
          _strip(
            eyebrow: 'DIAMOND',
            code: 'NS-04',
            decoration: deco(
              const NotchStyle.diamond(radius: 12),
              Mono.white,
              Mono.line,
            ),
          ),
        ],
      ),
    );
  }
}

class _DividerShot extends StatelessWidget {
  const _DividerShot();

  @override
  Widget build(BuildContext context) {
    Widget row(String name, TicketDivider divider, {bool dark = false}) =>
        _strip(
          eyebrow: name,
          code: dark ? 'BOARDING' : 'ADMIT ONE',
          height: 62,
          dark: dark,
          decoration: TicketcherDecoration(
            backgroundColor: dark ? Mono.black : Mono.white,
            borderRadius: const TicketRadius(radius: 12),
            divider: divider,
          ),
        );
    return _Shot(
      eyebrow: 'TicketDivider',
      title: 'A divider for\nevery ticket.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          row('DASHED', TicketDivider.dashed(color: Mono.ash)),
          const SizedBox(height: 10),
          row(
            'WAVE',
            TicketDivider.wave(color: Mono.blue, thickness: 2),
            dark: true,
          ),
          const SizedBox(height: 10),
          row('CIRCLES', TicketDivider.circles(color: Mono.blue)),
          const SizedBox(height: 10),
          row(
            'TEAR LINE',
            TicketDivider.tearLine(color: Mono.onDarkMuted),
            dark: true,
          ),
          const SizedBox(height: 10),
          row('DOUBLE LINE', TicketDivider.doubleLine(color: Mono.ink)),
        ],
      ),
    );
  }
}

class _EdgeShot extends StatelessWidget {
  const _EdgeShot();

  static List<Section> _receipt(String label, String value, bool dark) => [
    Section(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      child: SizedBox(
        width: double.infinity,
        height: 86,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(label, color: dark ? Mono.blueSoft : Mono.ash),
            const SizedBox(height: 6),
            _Big(value, color: dark ? Mono.onDark : Mono.ink, size: 22),
          ],
        ),
      ),
    ),
    Section(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Field('TOTAL', '\$120', dark: dark),
          Icon(Icons.qr_code_2, size: 30, color: dark ? Mono.onDark : Mono.ink),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'BorderPattern',
      title: 'Wave, sharp and\narc edges.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VTicketcher(
                width: 160,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.blue,
                  borderRadius: const TicketRadius(
                    radius: 14,
                    corner: TicketCorner.top,
                  ),
                  divider: TicketDivider.dashed(color: Mono.blueLight),
                  bottomBorderStyle: const BorderPattern(
                    shape: BorderShape.wave,
                    height: 6,
                    width: 16,
                  ),
                ),
                sections: _receipt('WAVE EDGE', 'COUPON\n−20%', true),
              ),
              const SizedBox(width: 14),
              VTicketcher(
                width: 160,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.white,
                  borderRadius: TicketRadius.zero,
                  divider: TicketDivider.dashed(color: Mono.line),
                  topBorderStyle: const BorderPattern(
                    shape: BorderShape.sharp,
                    height: 7,
                    width: 14,
                  ),
                  bottomBorderStyle: const BorderPattern(
                    shape: BorderShape.sharp,
                    height: 7,
                    width: 14,
                  ),
                ),
                sections: _receipt('SHARP EDGE', 'RECEIPT\n8821', false),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _strip(
            eyebrow: 'ARC EDGE',
            code: 'RAFFLE 042',
            dark: true,
            width: 334,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.black,
              divider: TicketDivider.dashed(color: Mono.graphite),
              leftBorderStyle: const BorderPattern(
                shape: BorderShape.arc,
                height: 6,
                width: 14,
              ),
              rightBorderStyle: const BorderPattern(
                shape: BorderShape.arc,
                height: 6,
                width: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientShot extends StatelessWidget {
  const _GradientShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'Gradients',
      title: 'Gradient tickets\nand sections.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              gradient: Mono.gradientNight,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(
                color: Mono.white.withValues(alpha: 0.35),
              ),
            ),
            sections: _gradientSections('WHOLE TICKET'),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(
                color: Mono.white.withValues(alpha: 0.35),
              ),
            ),
            sections: _gradientSections(
              'PER SECTION',
              top: Mono.gradientInk,
              bottom: Mono.gradientBlue,
            ),
          ),
        ],
      ),
    );
  }

  static List<Section> _gradientSections(
    String label, {
    Gradient? top,
    Gradient? bottom,
  }) => [
    Section(
      gradient: top,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(label, color: Mono.blueSoft),
            const SizedBox(height: 6),
            const _Big('NIGHT\nRUN', color: Mono.onDark, size: 28),
            const Spacer(),
            const Text(
              '10K · 21:00',
              style: TextStyle(fontSize: 12, color: Mono.blueSoft),
            ),
          ],
        ),
      ),
    ),
    Section(
      gradient: bottom,
      padding: const EdgeInsets.all(16),
      child: const SizedBox(
        width: double.infinity,
        height: 44,
        child: Align(
          alignment: Alignment.centerLeft,
          child: _Big('BIB 042', color: Mono.onDark, size: 18),
        ),
      ),
    ),
  ];
}

class _GradientBorderShot extends StatelessWidget {
  const _GradientBorderShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'borderGradient',
      title: 'Gradient borders.',
      child: VTicketcher(
        width: 300,
        decoration: TicketcherDecoration(
          backgroundColor: Mono.white,
          borderRadius: const TicketRadius(radius: 18),
          borderWidth: 4,
          borderGradient: const SweepGradient(
            colors: [
              Mono.blue,
              Mono.blueLight,
              Mono.black,
              Mono.blueDeep,
              Mono.blue,
            ],
          ),
          divider: TicketDivider.dashed(color: Mono.line),
        ),
        sections: _trainSections(
          route: 'VIP LOUNGE',
          kind: 'MEMBERS ONLY',
          label: Mono.blue,
        ),
      ),
    );
  }
}

class _ImageShot extends StatelessWidget {
  const _ImageShot();

  static const _mountains = NetworkImage(
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&q=80',
  );
  static const _stage = NetworkImage(
    'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=600&q=80',
  );
  static const images = [_mountains, _stage];

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'backgroundImage',
      title: 'Photo backgrounds,\nwhole or per section.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 160,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.black,
              backgroundImage: _mountains,
              backgroundImageOpacity: 0.75,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(
                color: Mono.white.withValues(alpha: 0.5),
              ),
            ),
            sections: _ExpiredShot._miniSections('TREK'),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 160,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.white,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.line),
            ),
            sections: const [
              Section(
                backgroundImage: _stage,
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Eyebrow('LIVE', color: Mono.white),
                      Spacer(),
                      _Big('MAIN\nSTAGE', color: Mono.onDark, size: 26),
                    ],
                  ),
                ),
              ),
              Section(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Icon(Icons.qr_code_2, size: 40, color: Mono.ink),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColoredSectionsShot extends StatelessWidget {
  const _ColoredSectionsShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'Section.color',
      title: 'Color every section.',
      child: VTicketcher(
        width: 300,
        decoration: TicketcherDecoration(
          borderRadius: const TicketRadius(radius: 16),
          divider: TicketDivider.dashed(
            color: Mono.white.withValues(alpha: 0.35),
          ),
        ),
        sections: const [
          Section(
            color: Mono.black,
            padding: EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Eyebrow('FLIGHT · TK 1964', color: Mono.blueLight),
                  SizedBox(height: 6),
                  _Big('IST → TIP', color: Mono.onDark, size: 28),
                ],
              ),
            ),
          ),
          Section(
            color: Mono.blue,
            padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Field('BOARDS', '07:15', dark: true),
                _Field('GATE', 'B4', dark: true),
                _Field('SEAT', '14A', dark: true, end: true),
              ],
            ),
          ),
          Section(
            color: Mono.white,
            padding: EdgeInsets.fromLTRB(20, 14, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Field('PASSENGER', 'L. HADDAD'),
                Icon(Icons.qr_code_2, size: 40, color: Mono.ink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassShot extends StatelessWidget {
  const _GlassShot();

  @override
  Widget build(BuildContext context) {
    Widget blob(double size, Color color) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    return _Shot(
      eyebrow: 'BlurEffect',
      title: 'Frosted glass.',
      child: SizedBox(
        width: 346,
        height: 330,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: Mono.gradientNight),
                ),
              ),
              Positioned(left: -30, top: -20, child: blob(170, Mono.blue)),
              Positioned(
                right: -40,
                bottom: -30,
                child: blob(190, Mono.blueLight),
              ),
              Positioned(right: 70, top: 40, child: blob(70, Mono.white)),
              VTicketcher(
                width: 230,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.white.withValues(alpha: 0.12),
                  borderRadius: const TicketRadius(radius: 18),
                  blurEffect: const BlurEffect.frosted(),
                  divider: TicketDivider.dashed(
                    color: Mono.white.withValues(alpha: 0.4),
                  ),
                ),
                sections: _trainSections(
                  dark: true,
                  route: 'AURORA',
                  kind: 'SKY DECK · 22:00',
                  label: Mono.blueSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WatermarkShot extends StatelessWidget {
  const _WatermarkShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'TicketWatermark',
      title: 'Text and widget\nwatermarks.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.black,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.graphite),
              watermark: const TicketWatermark.text(
                text: 'ORIGINAL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: Mono.blueLight,
                ),
                opacity: 0.35,
                rotation: 330,
                repeat: true,
                repeatSpacing: 26,
              ),
            ),
            sections: _ExpiredShot._miniSections('SEC'),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.white,
              borderRadius: const TicketRadius(radius: 16),
              divider: TicketDivider.dashed(color: Mono.line),
              watermark: const TicketWatermark.widget(
                widget: Icon(Icons.verified, size: 150, color: Mono.blue),
                width: 150,
                height: 150,
                opacity: 0.12,
              ),
            ),
            sections: [
              const Section(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Eyebrow('CERTIFIED', color: Mono.blue),
                      SizedBox(height: 6),
                      _Big('PASS\nHOLDER', size: 26),
                      Spacer(),
                      Text(
                        'Valid 2026',
                        style: TextStyle(fontSize: 12, color: Mono.ash),
                      ),
                    ],
                  ),
                ),
              ),
              const Section(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Icon(Icons.qr_code_2, size: 40, color: Mono.ink),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StitchShot extends StatelessWidget {
  const _StitchShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'TicketStitch',
      title: 'Stitched like\na leather pass.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.blue,
              borderRadius: const TicketRadius(radius: 16),
              stitch: const TicketStitch(color: Mono.blueSoft, inset: 9),
              divider: TicketDivider.dashed(color: Mono.blueLight),
            ),
            sections: _ExpiredShot._miniSections('CLUB'),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.black,
              borderRadius: const TicketRadius(radius: 16),
              stitch: const TicketStitch(
                color: Mono.ash,
                inset: 9,
                length: 4,
                spacing: 4,
                thickness: 1.5,
              ),
              divider: TicketDivider.dashed(color: Mono.graphite),
            ),
            sections: _ExpiredShot._miniSections('MEMBER'),
          ),
        ],
      ),
    );
  }
}

class _StackShot extends StatelessWidget {
  const _StackShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'StackEffect',
      title: 'A stack of tickets\nin one widget.',
      child: VTicketcher(
        width: 290,
        decoration: TicketcherDecoration(
          backgroundColor: Mono.white,
          borderRadius: const TicketRadius(radius: 16),
          divider: TicketDivider.dashed(color: Mono.line),
          stackEffect: const StackEffect(
            count: 3,
            offset: 10,
            widthStep: 18,
            color: Mono.blueLight,
          ),
        ),
        sections: _trainSections(
          route: '3 × RIDES',
          kind: 'METRO · DAY PASS',
          label: Mono.blue,
        ),
      ),
    );
  }
}

class _PunchShadowShot extends StatelessWidget {
  const _PunchShadowShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'Punch holes · shadows · dashed border',
      title: 'Lanyard-ready badges.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.white,
              borderRadius: const TicketRadius(radius: 16),
              punchHoles: const [
                PunchHole(
                  alignment: Alignment.topCenter,
                  offset: Offset(0, 18),
                  radius: 9,
                ),
              ],
              shadows: [
                BoxShadow(
                  color: Mono.black.withValues(alpha: 0.10),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Mono.black.withValues(alpha: 0.16),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
              divider: TicketDivider.dashed(color: Mono.line),
            ),
            sections: _badgeSections('SPEAKER', Mono.blue),
          ),
          const SizedBox(width: 14),
          VTicketcher(
            width: 165,
            decoration: TicketcherDecoration(
              backgroundColor: Mono.white,
              borderRadius: const TicketRadius(radius: 16),
              border: Border.all(color: Mono.blue, width: 2),
              borderDash: const BorderDash(dash: 8, gap: 5),
              punchHoles: const [
                PunchHole(
                  alignment: Alignment.topCenter,
                  offset: Offset(0, 18),
                  radius: 9,
                ),
              ],
              divider: TicketDivider.dashed(color: Mono.line),
            ),
            sections: _badgeSections('GUEST', Mono.ink),
          ),
        ],
      ),
    );
  }

  static List<Section> _badgeSections(String role, Color tint) => [
    Section(
      padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Eyebrow(role, color: tint),
            const SizedBox(height: 6),
            const _Big('Lina\nHaddad', size: 22),
            const Spacer(),
            const Text(
              'Flutter Forward',
              style: TextStyle(fontSize: 12, color: Mono.ash),
            ),
          ],
        ),
      ),
    ),
    const Section(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 40,
        child: Center(child: Icon(Icons.qr_code_2, size: 38, color: Mono.ink)),
      ),
    ),
  ];
}

class _BoardingPassShot extends StatelessWidget {
  const _BoardingPassShot();

  @override
  Widget build(BuildContext context) {
    return _Shot(
      eyebrow: 'Horizontal · multi-section',
      title: 'Boarding passes,\nany layout.',
      child: SizedBox(
        width: 346,
        child: Ticketcher.horizontal(
          height: 170,
          decoration: TicketcherDecoration(
            backgroundColor: Mono.black,
            borderRadius: const TicketRadius(radius: 16),
            divider: TicketDivider.dashed(color: Mono.graphite),
          ),
          sections: const [
            Section(
              widthFactor: 2.6,
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Eyebrow('TK 1964 · ECONOMY', color: Mono.blueLight),
                  Spacer(),
                  Row(
                    children: [
                      _Big('IST', color: Mono.onDark, size: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.flight_takeoff,
                          color: Mono.blue,
                          size: 22,
                        ),
                      ),
                      _Big('TIP', color: Mono.onDark, size: 30),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      _Field('BOARDS', '07:15', dark: true),
                      SizedBox(width: 18),
                      _Field('SEAT', '14A', dark: true),
                    ],
                  ),
                ],
              ),
            ),
            Section(
              color: Mono.blue,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Eyebrow('GATE', color: Mono.blueSoft),
                  SizedBox(height: 4),
                  _Big('B4', color: Mono.onDark, size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
