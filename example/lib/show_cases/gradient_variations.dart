import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class GradientVariations extends StatelessWidget {
  const GradientVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gradient Background Variations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('Holographic Effects', [
              _buildHolographicTicket(),
              _buildAuroraTicket(),
              _buildNeonTicket(),
            ]),
            const SizedBox(height: 32),
            _buildSection('Color Themes', [
              _buildSunsetTicket(),
              _buildOceanTicket(),
              _buildForestTicket(),
            ]),
            const SizedBox(height: 32),
            _buildSection('Advanced Gradients', [
              _buildDiamondTicket(),
              _buildRadialTicket(),
              _buildConicTicket(),
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
        ...children.map(
          (child) =>
              Padding(padding: const EdgeInsets.only(bottom: 16), child: child),
        ),
      ],
    );
  }

  Widget _buildHolographicTicket() {
    return Ticketcher.horizontal(
      height: 140,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Mono.blueNight,
            Mono.blueDeep,
            Mono.blue,
            Mono.blueLight,
            Mono.blueDeep,
            Mono.blueNight,
          ],
          stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
        ),
        shadow: BoxShadow(
          color: Mono.blue.withValues(alpha: 0.3),
          blurRadius: 15,
          offset: const Offset(0, 8),
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
                'HOLOGRAPHIC',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Premium Access',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
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
              Icon(Icons.stars, color: Mono.onDark, size: 32),
              Text(
                'VIP',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuroraTicket() {
    return Ticketcher.vertical(
      width: 200,
      notchRadius: 15,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Mono.blueLight,
            Mono.blue,
            Mono.blueDeep,
            Mono.blueNight,
            Mono.black,
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
        shadow: BoxShadow(
          color: Mono.blueDeep.withValues(alpha: 0.35),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Icon(Icons.nights_stay, color: Mono.onDark, size: 40),
              SizedBox(height: 8),
              Text(
                'AURORA',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Text(
                'Northern Lights Experience',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Premium Package',
                style: TextStyle(color: Mono.blueSoft, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNeonTicket() {
    return Ticketcher.horizontal(
      height: 120,
      notchRadius: 8,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Mono.black,
        gradient: const LinearGradient(
          colors: [Mono.black, Mono.blueNight, Mono.blue],
        ),
        border: Border.all(color: Mono.blueLight, width: 2),
        shadow: BoxShadow(
          color: Mono.blue.withValues(alpha: 0.5),
          blurRadius: 15,
          offset: const Offset(0, 0),
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
              Icon(Icons.flash_on, color: Mono.onDark, size: 32),
              Text(
                'NEON',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
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
                'ELECTRIC VIBES',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cyberpunk Experience',
                style: TextStyle(color: Mono.blueSoft, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSunsetTicket() {
    return Ticketcher.vertical(
      width: 180,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Mono.blueLight, Mono.blue, Mono.blueDeep, Mono.black],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.wb_sunny, color: Mono.onDark, size: 32),
              Text(
                'SUNSET',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(12),
          child: const Text(
            'Golden Hour\nExperience',
            textAlign: TextAlign.center,
            style: TextStyle(color: Mono.onDark, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildOceanTicket() {
    return Ticketcher.horizontal(
      height: 100,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        gradient: const LinearGradient(
          colors: [Mono.blue, Mono.blueNight, Mono.blueDeep, Mono.blue],
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.waves, color: Mono.onDark, size: 28),
              Text(
                'OCEAN',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 12,
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
                'Deep Blue',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Marine Adventure',
                style: TextStyle(color: Mono.blueSoft, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForestTicket() {
    return Ticketcher.vertical(
      width: 160,
      notchRadius: 8,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        gradient: const LinearGradient(
          colors: [Mono.black, Mono.graphite, Mono.blueDeep],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.forest, color: Mono.onDark, size: 32),
              Text(
                'FOREST',
                style: TextStyle(
                  color: Mono.onDark,
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
            'Nature Walk',
            textAlign: TextAlign.center,
            style: TextStyle(color: Mono.onDark, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDiamondTicket() {
    return Ticketcher.horizontal(
      height: 120,
      notchRadius: 15,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 20),
        gradient: const SweepGradient(
          center: Alignment.center,
          colors: [Mono.white, Mono.panel, Mono.line, Mono.panel, Mono.white],
        ),
        border: Border.all(color: Mono.line, width: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.diamond, color: Mono.blue, size: 32),
              Text(
                'DIAMOND',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 12,
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
                'PREMIUM MEMBER',
                style: TextStyle(
                  color: Mono.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Exclusive Benefits',
                style: TextStyle(color: Mono.ash, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadialTicket() {
    return Ticketcher.vertical(
      width: 180,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        gradient: const RadialGradient(
          center: Alignment.center,
          colors: [Mono.blueLight, Mono.blue, Mono.blueDeep, Mono.blueNight],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.radio_button_checked, color: Mono.onDark, size: 32),
              Text(
                'RADIAL',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(12),
          child: const Text(
            'Burst Effect',
            textAlign: TextAlign.center,
            style: TextStyle(color: Mono.onDark, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildConicTicket() {
    return Ticketcher.horizontal(
      height: 100,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        gradient: const SweepGradient(
          colors: [
            Mono.blueNight,
            Mono.blueDeep,
            Mono.blue,
            Mono.blueLight,
            Mono.blue,
            Mono.blueDeep,
            Mono.blueNight,
            Mono.black,
            Mono.graphite,
            Mono.black,
            Mono.blueNight,
          ],
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.color_lens, color: Mono.onDark, size: 28),
              Text(
                'RAINBOW',
                style: TextStyle(
                  color: Mono.onDark,
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
                'SPECTRUM',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Full Color Range',
                style: TextStyle(color: Mono.blueSoft, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
