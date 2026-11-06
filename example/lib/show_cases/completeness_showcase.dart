import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

/// Showcases the five 2.1.0 features: multi-shadow, top border pattern,
/// dashed outer border, per-boundary dividers, punch holes.
class CompletenessShowcase extends StatelessWidget {
  const CompletenessShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2.1.0 Features')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _label('Multi-shadow — layered blue glow'),
            Ticketcher(
              sections: _sections('Concert Pass', 'ROW 4 · SEAT 12'),
              decoration: TicketcherDecoration(
                backgroundColor: Mono.white,
                shadows: [
                  BoxShadow(
                    color: Mono.blue.withValues(alpha: 0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Mono.blueLight.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Mono.black.withValues(alpha: 0.2),
                    blurRadius: 36,
                    offset: const Offset(0, 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _label('Top border pattern — receipt-style torn edge'),
            Ticketcher(
              sections: _sections('Store Receipt', 'TOTAL \$42.00'),
              decoration: TicketcherDecoration(
                backgroundColor: Mono.white,
                borderRadius: TicketRadius.zero,
                topBorderStyle: const BorderPattern(
                  shape: BorderShape.sharp,
                  height: 8,
                  width: 20,
                ),
                shadow: BoxShadow(
                  color: Mono.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Dashed gradient border — coupon cut line'),
            Ticketcher(
              sections: _sections('25% OFF', 'CODE: TKT-25-OFF'),
              decoration: const TicketcherDecoration(
                backgroundColor: Mono.blueTint,
                borderGradient: LinearGradient(
                  colors: [Mono.blueNight, Mono.blue],
                ),
                borderWidth: 2,
                borderDash: BorderDash(dash: 7, gap: 5),
              ),
            ),
            const SizedBox(height: 40),
            _label('Per-boundary dividers — tear line then wave'),
            Ticketcher(
              sections: [
                Section(
                  padding: const EdgeInsets.all(20),
                  dividerAfter: TicketDivider.tearLine(
                    color: Mono.ash,
                    dashWidth: 5,
                    dashSpace: 4,
                    scissorsPosition: ScissorsPosition.start,
                  ),
                  child: const Text(
                    'Boarding Pass',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Mono.ink,
                    ),
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(20),
                  dividerAfter: TicketDivider.smoothWave(
                    color: Mono.blue,
                    waveHeight: 6,
                    waveWidth: 10,
                  ),
                  child: const Text(
                    'Gate B12 · Boarding 18:40',
                    style: Mono.body,
                  ),
                ),
                const Section(
                  padding: EdgeInsets.all(20),
                  child: Text('Keep this stub', style: Mono.caption),
                ),
              ],
              decoration: TicketcherDecoration(
                backgroundColor: Mono.white,
                shadow: BoxShadow(
                  color: Mono.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Punch hole — lanyard-ready cutout'),
            Ticketcher(
              sections: _sections('VIP BACKSTAGE', 'ALL ACCESS', dark: true),
              decoration: const TicketcherDecoration(
                backgroundColor: Mono.black,
                border: Border.fromBorderSide(
                  BorderSide(color: Mono.blue, width: 1.5),
                ),
                punchHoles: [
                  PunchHole(
                    alignment: Alignment.topCenter,
                    offset: Offset(0, 15),
                    radius: 7,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  List<Section> _sections(String title, String subtitle, {bool dark = false}) {
    return [
      Section(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: dark ? Mono.onDark : Mono.ink,
          ),
        ),
      ),
      Section(
        padding: const EdgeInsets.all(20),
        child: Text(
          subtitle,
          style: TextStyle(
            letterSpacing: 1.5,
            color: dark ? Mono.blueLight : Mono.ash,
          ),
        ),
      ),
    ];
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Mono.ash)),
    );
  }
}
