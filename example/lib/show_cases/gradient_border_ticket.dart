import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class GradientBorderTicket extends StatelessWidget {
  const GradientBorderTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            fontWeight: FontWeight.bold,
            color: Colors.black87,
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
        backgroundColor: Colors.white,
        borderGradient: const LinearGradient(
          colors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
          ],
        ),
        borderWidth: 3.0,
        shadow: BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
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
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gradient Border Demo',
                style: TextStyle(color: Colors.black54, fontSize: 14),
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
              Icon(Icons.palette, color: Colors.black54, size: 32),
              SizedBox(height: 8),
              Text(
                'COLORFUL',
                style: TextStyle(
                  color: Colors.black87,
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
        backgroundColor: Colors.black,
        borderGradient: const LinearGradient(
          colors: [
            Color(0xFF00FFFF),
            Color(0xFF0080FF),
            Color(0xFF8000FF),
            Color(0xFFFF00FF),
            Color(0xFF00FFFF),
          ],
        ),
        borderWidth: 2.5,
        shadow: BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.5),
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
              Icon(Icons.flash_on, color: Colors.white, size: 28),
              SizedBox(height: 4),
              Text(
                'NEON',
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Electric Vibes',
                style: TextStyle(color: Colors.white70, fontSize: 11),
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
        backgroundColor: Colors.white,
        borderGradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFD89B), Color(0xFFFF8A56), Color(0xFFFF6B6B)],
        ),
        borderWidth: 2.0,
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
              SizedBox(height: 8),
              Text(
                'SUNSET',
                style: TextStyle(
                  color: Colors.black87,
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
            style: TextStyle(color: Colors.black54, fontSize: 12),
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
        backgroundColor: Colors.white,
        borderGradient: const LinearGradient(
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF89f7fe),
            Color(0xFF66a6ff),
          ],
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
              Icon(Icons.waves, color: Colors.blue, size: 28),
              Text(
                'OCEAN',
                style: TextStyle(
                  color: Colors.black87,
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
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Marine Vibes',
                style: TextStyle(color: Colors.black54, fontSize: 10),
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
        backgroundColor: Colors.white,
        borderGradient: const LinearGradient(
          colors: [
            Color(0xFFFFD700), // Gold
            Color(0xFFFFA500), // Orange
            Color(0xFFFFD700), // Gold
            Color(0xFFB8860B), // Dark golden rod
            Color(0xFFFFD700), // Gold
          ],
        ),
        borderWidth: 3.0,
        shadow: BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 32),
              SizedBox(height: 8),
              Text(
                'PREMIUM',
                style: TextStyle(
                  color: Colors.black87,
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
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
