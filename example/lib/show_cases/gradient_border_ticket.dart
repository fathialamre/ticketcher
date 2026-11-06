import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class GradientBorderTicket extends StatelessWidget {
  const GradientBorderTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gradient Border Tickets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('Rainbow Border', [_buildRainbowBorderTicket()]),
            const SizedBox(height: 32),
            _buildSection('Neon Glow Border', [_buildNeonGlowBorderTicket()]),
            const SizedBox(height: 32),
            _buildSection('Gradient Border Variations', [
              _buildSunsetBorderTicket(),
              const SizedBox(height: 16),
              _buildOceanBorderTicket(),
              const SizedBox(height: 16),
              _buildMetallicBorderTicket(),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: Mono.ink,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildRainbowBorderTicket() {
    return Ticketcher.horizontal(
      height: 140,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Mono.white,
        borderGradient: const LinearGradient(
          colors: [
            Mono.black,
            Mono.blueNight,
            Mono.blueDeep,
            Mono.blue,
            Mono.blueLight,
            Mono.blueSoft,
            Mono.blueLight,
          ],
        ),
        borderWidth: 3.0,
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ),
      sections: [
        Section(
          widthFactor: 2,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RAINBOW TICKET',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gradient Border Demo',
                style: TextStyle(color: Mono.ash, fontSize: 14),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.palette, color: Mono.ash, size: 32),
              SizedBox(height: 8),
              Text(
                'COLORFUL',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNeonGlowBorderTicket() {
    return Ticketcher.horizontal(
      height: 120,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Mono.black,
        borderGradient: const LinearGradient(
          colors: [
            Mono.blueLight,
            Mono.blue,
            Mono.blueDeep,
            Mono.blue,
            Mono.blueLight,
          ],
        ),
        borderWidth: 2.5,
        shadow: BoxShadow(
          color: Mono.blue.withValues(alpha: 0.45),
          blurRadius: 15,
          spreadRadius: 2,
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flash_on, color: Mono.blueLight, size: 28),
              SizedBox(height: 4),
              Text(
                'NEON',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 2,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CYBER BORDER',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Electric Vibes',
                style: TextStyle(color: Mono.onDarkMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSunsetBorderTicket() {
    return Ticketcher.vertical(
      width: 200,
      notchRadius: 8,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 14),
        backgroundColor: Mono.white,
        borderGradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Mono.blueSoft, Mono.blueLight, Mono.blue],
        ),
        borderWidth: 2.0,
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.wb_sunny, color: Mono.blue, size: 32),
              SizedBox(height: 8),
              Text(
                'SUNSET',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(12),
          child: const Text(
            'Golden Hour\nBorder',
            textAlign: TextAlign.center,
            style: TextStyle(color: Mono.ash, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildOceanBorderTicket() {
    return Ticketcher.horizontal(
      height: 100,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Mono.white,
        borderGradient: const LinearGradient(
          colors: [Mono.blueNight, Mono.blue, Mono.blueSoft, Mono.blueLight],
        ),
        borderWidth: 2.5,
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.waves, color: Mono.blue, size: 28),
              Text(
                'OCEAN',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 2,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deep Blue Border',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Marine Vibes',
                style: TextStyle(color: Mono.ash, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetallicBorderTicket() {
    return Ticketcher.vertical(
      width: 180,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 18),
        backgroundColor: Mono.white,
        borderGradient: const LinearGradient(
          colors: [
            Mono.line, // Silver
            Mono.ash, // Steel
            Mono.panel, // Highlight
            Mono.graphite, // Shadow
            Mono.line, // Silver
          ],
        ),
        borderWidth: 3.0,
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.star, color: Mono.black, size: 32),
              SizedBox(height: 8),
              Text(
                'PREMIUM',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(12),
          child: const Text(
            'Golden\nBorder',
            textAlign: TextAlign.center,
            style: TextStyle(color: Mono.ash, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
