import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
            _label('Multi-shadow — layered colored glow'),
            Ticketcher(
              sections: _sections('Concert Pass', 'ROW 4 · SEAT 12'),
              decoration: const TicketcherDecoration(
                shadows: [
                  BoxShadow(
                    color: Color(0x806366F1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Color(0x59EC4899),
                    blurRadius: 18,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x330F172A),
                    blurRadius: 36,
                    offset: Offset(0, 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _label('Top border pattern — receipt-style torn edge'),
            Ticketcher(
              sections: _sections('Store Receipt', 'TOTAL \$42.00'),
              decoration: const TicketcherDecoration(
                borderRadius: TicketRadius.zero,
                topBorderStyle: BorderPattern(
                  shape: BorderShape.sharp,
                  height: 8,
                  width: 20,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Dashed gradient border — coupon cut line'),
            Ticketcher(
              sections: _sections('25% OFF', 'CODE: TKT-25-OFF'),
              decoration: const TicketcherDecoration(
                backgroundColor: Color(0xFFFFFBEB),
                borderGradient: LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
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
                    color: Colors.grey,
                    dashWidth: 5,
                    dashSpace: 4,
                    scissorsPosition: ScissorsPosition.start,
                  ),
                  child: const Text(
                    'Boarding Pass',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(20),
                  dividerAfter: TicketDivider.smoothWave(
                    color: Colors.deepPurple,
                    waveHeight: 6,
                    waveWidth: 10,
                  ),
                  child: const Text('Gate B12 · Boarding 18:40'),
                ),
                const Section(
                  padding: EdgeInsets.all(20),
                  child: Text('Keep this stub'),
                ),
              ],
              decoration: const TicketcherDecoration(
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _label('Punch hole — lanyard-ready cutout'),
            Ticketcher(
              sections: _sections('VIP BACKSTAGE', 'ALL ACCESS'),
              decoration: const TicketcherDecoration(
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFFD946EF), width: 1.5),
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

  List<Section> _sections(String title, String subtitle) {
    return [
      Section(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      Section(
        padding: const EdgeInsets.all(20),
        child: Text(subtitle, style: const TextStyle(letterSpacing: 1.5)),
      ),
    ];
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }
}
