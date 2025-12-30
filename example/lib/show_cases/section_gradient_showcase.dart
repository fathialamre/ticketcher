import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class SectionGradientShowcase extends StatelessWidget {
  const SectionGradientShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Section Gradient Backgrounds')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection('Linear Gradients', [
              _buildLinearGradientHorizontal(context),
              _buildLinearGradientVertical(context),
              _buildLinearGradientMultiSection(context),
            ]),
            const SizedBox(height: 32),
            _buildSection('Radial Gradients', [
              _buildRadialGradientTicket(context),
              _buildRadialGradientMultiSection(context),
            ]),
            const SizedBox(height: 32),
            _buildSection('Sweep Gradients', [
              _buildSweepGradientTicket(context),
              _buildSweepGradientMultiSection(context),
            ]),
            const SizedBox(height: 32),
            _buildSection('Mixed Gradients', [
              _buildMixedGradientTicket(context),
              _buildColorfulGradientTicket(context),
            ]),
            const SizedBox(height: 32),
            _buildSection('Gradient Precedence', [
              _buildGradientPrecedenceExample(context),
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

  // Linear Gradient Examples
  Widget _buildLinearGradientHorizontal(BuildContext context) {
    return Ticketcher.horizontal(
      height: 140,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Colors.grey.shade300, thickness: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GRADIENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Section 1',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECTION',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Section 2',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinearGradientVertical(BuildContext context) {
    return Ticketcher.vertical(
      width: 200,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Colors.grey.shade300, thickness: 1),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BOTTOM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinearGradientMultiSection(BuildContext context) {
    return Ticketcher.horizontal(
      height: 120,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade600],
          ),
          child: const Center(
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade400, Colors.purple.shade600],
          ),
          child: const Center(
            child: Text(
              '2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade400, Colors.pink.shade600],
          ),
          child: const Center(
            child: Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Radial Gradient Examples
  Widget _buildRadialGradientTicket(BuildContext context) {
    return Ticketcher.horizontal(
      height: 150,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Colors.grey.shade300, thickness: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F), Color(0xFFC44569)],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.white, size: 32),
              SizedBox(height: 8),
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
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.water_drop, color: Colors.white, size: 32),
              SizedBox(height: 8),
              Text(
                'GRADIENT',
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

  Widget _buildRadialGradientMultiSection(BuildContext context) {
    return Ticketcher.vertical(
      width: 180,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Colors.orange.shade300, Colors.orange.shade600],
          ),
          child: const Center(
            child: Text(
              'SUNSET',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Colors.teal.shade300, Colors.teal.shade600],
          ),
          child: const Center(
            child: Text(
              'OCEAN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Colors.green.shade300, Colors.green.shade600],
          ),
          child: const Center(
            child: Text(
              'FOREST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Sweep Gradient Examples
  Widget _buildSweepGradientTicket(BuildContext context) {
    return Ticketcher.horizontal(
      height: 140,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Colors.grey.shade300, thickness: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: 3.14159 * 2,
            colors: [
              Color(0xFFFF0080),
              Color(0xFF7928CA),
              Color(0xFF0070F3),
              Color(0xFF00DFD8),
              Color(0xFFFF0080),
            ],
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.color_lens, color: Colors.white, size: 32),
              SizedBox(height: 8),
              Text(
                'SWEEP',
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
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: 3.14159 * 2,
            colors: [
              Color(0xFFFF6B6B),
              Color(0xFFFFE66D),
              Color(0xFF4ECDC4),
              Color(0xFF45B7D1),
              Color(0xFFFF6B6B),
            ],
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.palette, color: Colors.white, size: 32),
              SizedBox(height: 8),
              Text(
                'GRADIENT',
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

  Widget _buildSweepGradientMultiSection(BuildContext context) {
    return Ticketcher.vertical(
      width: 200,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: SweepGradient(
            center: Alignment.center,
            colors: [
              Colors.red.shade300,
              Colors.orange.shade300,
              Colors.yellow.shade300,
              Colors.red.shade300,
            ],
          ),
          child: const Center(
            child: Text(
              'RAINBOW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: SweepGradient(
            center: Alignment.center,
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade300,
              Colors.pink.shade300,
              Colors.blue.shade300,
            ],
          ),
          child: const Center(
            child: Text(
              'SPECTRUM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Mixed Gradient Examples
  Widget _buildMixedGradientTicket(BuildContext context) {
    return Ticketcher.horizontal(
      height: 160,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.dashed(
          color: Colors.grey.shade400,
          thickness: 1,
          dashWidth: 8,
          dashSpace: 4,
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LINEAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RADIAL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D), Color(0xFF4ECDC4)],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SWEEP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorfulGradientTicket(BuildContext context) {
    return Ticketcher.vertical(
      width: 220,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.wave(
          color: Colors.grey.shade400,
          thickness: 2,
          waveHeight: 4,
          waveWidth: 8,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D), Color(0xFF4ECDC4)],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.white, size: 40),
              SizedBox(height: 12),
              Text(
                'PREMIUM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFFF093FB)],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.diamond, color: Colors.white, size: 40),
              SizedBox(height: 12),
              Text(
                'DELUXE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Gradient Precedence Example
  Widget _buildGradientPrecedenceExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Precedence: backgroundImage > gradient > color',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Ticketcher.horizontal(
          height: 120,
          notchRadius: 10,
          decoration: TicketcherDecoration(
            borderRadius: const TicketRadius(radius: 12),
            backgroundColor: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1),
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ),
          sections: [
            Section(
              widthFactor: 1,
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade200, // This will be overridden by gradient
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              child: const Center(
                child: Text(
                  'GRADIENT\n(overrides color)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Section(
              widthFactor: 1,
              padding: const EdgeInsets.all(12),
              color: Colors.blue.shade200, // This will be used
              child: const Center(
                child: Text(
                  'COLOR\n(no gradient)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
