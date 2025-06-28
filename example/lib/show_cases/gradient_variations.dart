import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class GradientVariations extends StatelessWidget {
  const GradientVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            fontWeight: FontWeight.bold,
            color: Colors.black87,
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
            Color(0xFFFF0080),
            Color(0xFF7928CA),
            Color(0xFF0070F3),
            Color(0xFF00DFD8),
            Color(0xFF7928CA),
            Color(0xFFFF0080),
          ],
          stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
        ),
        shadow: BoxShadow(
          color: Colors.purple.withOpacity(0.3),
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
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Premium Access',
                style: TextStyle(color: Colors.white70, fontSize: 12),
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
              Icon(Icons.stars, color: Colors.white, size: 32),
              Text(
                'VIP',
                style: TextStyle(
                  color: Colors.white,
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
            Color(0xFF00FF87),
            Color(0xFF60EFFF),
            Color(0xFF0061FF),
            Color(0xFF6B73FF),
            Color(0xFF9B59B6),
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
        shadow: BoxShadow(
          color: Colors.cyan.withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Icon(Icons.nights_stay, color: Colors.white, size: 40),
              SizedBox(height: 8),
              Text(
                'AURORA',
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Premium Package',
                style: TextStyle(color: Colors.white70, fontSize: 10),
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
        backgroundColor: Colors.black,
        gradient: const LinearGradient(
          colors: [Color(0xFFFF006E), Color(0xFF8338EC), Color(0xFF3A86FF)],
        ),
        border: Border.all(color: Colors.cyan, width: 2),
        shadow: BoxShadow(
          color: Colors.cyan.withOpacity(0.5),
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
              Icon(Icons.flash_on, color: Colors.white, size: 32),
              Text(
                'NEON',
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cyberpunk Experience',
                style: TextStyle(color: Colors.white70, fontSize: 10),
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
          colors: [
            Color(0xFFFFD89B),
            Color(0xFFFF8A56),
            Color(0xFFFF6B6B),
            Color(0xFF4ECDC4),
          ],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.wb_sunny, color: Colors.white, size: 32),
              Text(
                'SUNSET',
                style: TextStyle(
                  color: Colors.white,
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
            style: TextStyle(color: Colors.white, fontSize: 12),
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
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF89f7fe),
            Color(0xFF66a6ff),
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
              Icon(Icons.waves, color: Colors.white, size: 28),
              Text(
                'OCEAN',
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Marine Adventure',
                style: TextStyle(color: Colors.white70, fontSize: 10),
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
          colors: [Color(0xFF134E5E), Color(0xFF71B280), Color(0xFF92C5F7)],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.forest, color: Colors.white, size: 32),
              Text(
                'FOREST',
                style: TextStyle(
                  color: Colors.white,
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
            style: TextStyle(color: Colors.white, fontSize: 12),
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
          colors: [
            Colors.white,
            Color(0xFFE3E3E3),
            Color(0xFFB8B8B8),
            Color(0xFFE3E3E3),
            Colors.white,
          ],
        ),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.diamond, color: Colors.black54, size: 32),
              Text(
                'DIAMOND',
                style: TextStyle(
                  color: Colors.black87,
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
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Exclusive Benefits',
                style: TextStyle(color: Colors.black54, fontSize: 10),
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
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFF9A9E),
            Color(0xFFFAD0C4),
            Color(0xFFFF9A9E),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: const Column(
            children: [
              Icon(Icons.radio_button_checked, color: Colors.white, size: 32),
              Text(
                'RADIAL',
                style: TextStyle(
                  color: Colors.white,
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
            style: TextStyle(color: Colors.white, fontSize: 12),
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
            Color(0xFFFF0000),
            Color(0xFFFF8000),
            Color(0xFFFFFF00),
            Color(0xFF80FF00),
            Color(0xFF00FF00),
            Color(0xFF00FF80),
            Color(0xFF00FFFF),
            Color(0xFF0080FF),
            Color(0xFF0000FF),
            Color(0xFF8000FF),
            Color(0xFFFF00FF),
            Color(0xFFFF0080),
            Color(0xFFFF0000),
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
              Icon(Icons.color_lens, color: Colors.white, size: 28),
              Text(
                'RAINBOW',
                style: TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Full Color Range',
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
