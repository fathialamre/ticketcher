import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class SectionGradientShowcase extends StatelessWidget {
  const SectionGradientShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  // Linear Gradient Examples
  Widget _buildLinearGradientHorizontal(BuildContext context) {
    return Ticketcher.horizontal(
      height: 140,
      notchRadius: 12,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 16),
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Mono.line, thickness: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Mono.blue, Mono.blueNight],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GRADIENT',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Section 1',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
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
            colors: [Mono.ash, Mono.black],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECTION',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Section 2',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Mono.line, thickness: 1),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Mono.blue, Mono.blueDeep],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TOP',
                style: TextStyle(
                  color: Mono.onDark,
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
            colors: [Mono.graphite, Mono.black],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BOTTOM',
                style: TextStyle(
                  color: Mono.onDark,
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Mono.blueLight, Mono.blue],
          ),
          child: const Center(
            child: Text(
              '1',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Mono.blue, Mono.blueDeep],
          ),
          child: const Center(
            child: Text(
              '2',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Mono.blueDeep, Mono.blueNight],
          ),
          child: const Center(
            child: Text(
              '3',
              style: TextStyle(
                color: Mono.onDark,
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Mono.line, thickness: 1),
      ),
      sections: [
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [Mono.blueLight, Mono.blue, Mono.blueDeep],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Mono.onDark, size: 32),
              SizedBox(height: 8),
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
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [Mono.ash, Mono.black],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.water_drop, color: Mono.onDark, size: 32),
              SizedBox(height: 8),
              Text(
                'GRADIENT',
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

  Widget _buildRadialGradientMultiSection(BuildContext context) {
    return Ticketcher.vertical(
      width: 180,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Mono.blueLight, Mono.blue],
          ),
          child: const Center(
            child: Text(
              'SUNSET',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Mono.blue, Mono.blueNight],
          ),
          child: const Center(
            child: Text(
              'OCEAN',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [Mono.ash, Mono.black],
          ),
          child: const Center(
            child: Text(
              'FOREST',
              style: TextStyle(
                color: Mono.onDark,
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.solid(color: Mono.line, thickness: 1),
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
              Mono.blueNight,
              Mono.blue,
              Mono.blueLight,
              Mono.blue,
              Mono.blueNight,
            ],
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.color_lens, color: Mono.onDark, size: 32),
              SizedBox(height: 8),
              Text(
                'SWEEP',
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
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            startAngle: 0.0,
            endAngle: 3.14159 * 2,
            colors: [
              Mono.black,
              Mono.graphite,
              Mono.ash,
              Mono.graphite,
              Mono.black,
            ],
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.palette, color: Mono.onDark, size: 32),
              SizedBox(height: 8),
              Text(
                'GRADIENT',
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

  Widget _buildSweepGradientMultiSection(BuildContext context) {
    return Ticketcher.vertical(
      width: 200,
      notchRadius: 10,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 12),
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            colors: [Mono.blue, Mono.blueLight, Mono.blueDeep, Mono.blue],
          ),
          child: const Center(
            child: Text(
              'RAINBOW',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Section(
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            colors: [Mono.graphite, Mono.blue, Mono.black, Mono.graphite],
          ),
          child: const Center(
            child: Text(
              'SPECTRUM',
              style: TextStyle(
                color: Mono.onDark,
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.dashed(
          color: Mono.ash,
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
            colors: [Mono.blue, Mono.blueNight],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LINEAR',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
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
            colors: [Mono.ash, Mono.black],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RADIAL',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 1,
          padding: const EdgeInsets.all(16),
          gradient: const SweepGradient(
            center: Alignment.center,
            colors: [Mono.blue, Mono.blueNight, Mono.blue],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SWEEP',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gradient',
                style: TextStyle(color: Mono.blueSoft, fontSize: 12),
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
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1),
        shadow: BoxShadow(
          color: Mono.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        divider: TicketDivider.wave(
          color: Mono.ash,
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
            colors: [Mono.blueNight, Mono.blue, Mono.blueLight],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Mono.onDark, size: 40),
              SizedBox(height: 12),
              Text(
                'PREMIUM',
                style: TextStyle(
                  color: Mono.onDark,
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
            colors: [Mono.black, Mono.graphite, Mono.blueDeep],
            stops: [0.0, 0.5, 1.0],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.diamond, color: Mono.onDark, size: 40),
              SizedBox(height: 12),
              Text(
                'DELUXE',
                style: TextStyle(
                  color: Mono.onDark,
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
              color: Mono.ash,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Ticketcher.horizontal(
          height: 120,
          notchRadius: 10,
          decoration: TicketcherDecoration(
            borderRadius: const TicketRadius(radius: 12),
            backgroundColor: Mono.white,
            border: Border.all(color: Mono.line, width: 1),
            shadow: BoxShadow(
              color: Mono.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ),
          sections: [
            Section(
              widthFactor: 1,
              padding: const EdgeInsets.all(12),
              color: Mono.panel, // This will be overridden by gradient
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Mono.blue, Mono.blueNight],
              ),
              child: const Center(
                child: Text(
                  'GRADIENT\n(overrides color)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Mono.onDark,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Section(
              widthFactor: 1,
              padding: const EdgeInsets.all(12),
              color: Mono.blueSoft, // This will be used
              child: const Center(
                child: Text(
                  'COLOR\n(no gradient)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Mono.ink,
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
