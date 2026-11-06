import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class AdvancedDividersShowcase extends StatelessWidget {
  const AdvancedDividersShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Dividers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Solid Divider'),
            _buildSolidDividerTicket(context),
            const SizedBox(height: 28),
            _buildSectionTitle('Dashed Divider'),
            _buildDashedDividerTicket(context),
            const SizedBox(height: 28),
            _buildSectionTitle('Circle Divider'),
            _buildCircleDividerTicket(context),
            const SizedBox(height: 28),
            _buildSectionTitle('Wave Divider'),
            _buildWaveDividerTicket(context),
            const SizedBox(height: 28),
            _buildSectionTitle('Horizontal Dashed Divider'),
            _buildHorizontalDashedTicket(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Mono.ink,
        ),
      ),
    );
  }

  Widget _buildSolidDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1.5),
        divider: TicketDivider.solid(color: Mono.line, thickness: 2),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Mono.blueTint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.horizontal_rule, color: Mono.blue, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Solid Divider',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Mono.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Clean straight line divider',
                      style: TextStyle(fontSize: 13, color: Mono.ash),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Simple and elegant',
                style: TextStyle(
                  fontSize: 12,
                  color: Mono.ash,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Mono.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SOLID',
                  style: TextStyle(
                    color: Mono.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Mono.blue,
        border: Border.all(color: Mono.blue, width: 1.5),
        divider: TicketDivider.dashed(
          color: Mono.blueLight,
          thickness: 2,
          dashWidth: 8,
          dashSpace: 4,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '20% OFF',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Mono.onDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Mono.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'COUPON',
                      style: TextStyle(
                        color: Mono.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Valid for your next purchase',
                style: TextStyle(fontSize: 14, color: Mono.blueSoft),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CODE',
                    style: TextStyle(
                      fontSize: 10,
                      color: Mono.blueSoft,
                      letterSpacing: 1,
                    ),
                  ),
                  const Text(
                    'SAVE20',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: Mono.onDark,
                    ),
                  ),
                ],
              ),
              const Text(
                'Dashed divider',
                style: TextStyle(
                  fontSize: 12,
                  color: Mono.blueSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Mono.black,
        border: Border.all(color: Mono.graphite, width: 1.5),
        divider: TicketDivider.circles(
          color: Mono.white.withValues(alpha: 0.35),
          thickness: 2,
          circleRadius: 4,
          circleSpacing: 12,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: Mono.gradientBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.circle_outlined,
                  color: Mono.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Circle Divider',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Mono.onDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Beautiful circular pattern',
                      style: TextStyle(fontSize: 13, color: Mono.onDarkMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircleStat('Radius', '4px', Mono.blue),
              _buildCircleStat('Spacing', '12px', Mono.blueLight),
              _buildCircleStat('Style', 'Filled', Mono.white),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWaveDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line, width: 1.5),
        divider: TicketDivider.wave(
          color: Mono.line,
          thickness: 2,
          waveHeight: 4,
          waveWidth: 16,
        ),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: Mono.gradientInk,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.waves, color: Mono.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wave Divider',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Mono.ink,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Smooth wave pattern divider',
                      style: TextStyle(fontSize: 13, color: Mono.ash),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Section(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Height: 4px • Width: 16px',
                style: TextStyle(fontSize: 12, color: Mono.ash),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: Mono.gradientBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'WAVE',
                  style: TextStyle(
                    color: Mono.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalDashedTicket(BuildContext context) {
    return Ticketcher.horizontal(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 12, corner: TicketCorner.all),
        gradient: Mono.gradientNight,
        border: Border.all(color: Mono.blueNight, width: 1.5),
        divider: TicketDivider.dashed(
          color: Mono.blueLight,
          thickness: 2,
          dashWidth: 6,
          dashSpace: 4,
        ),
      ),
      sections: [
        Section(
          widthFactor: 0.35,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.more_vert, color: Mono.white, size: 32),
              SizedBox(height: 8),
              Text(
                'VERTICAL',
                style: TextStyle(
                  color: Mono.blueSoft,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'DASHED',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 0.65,
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Horizontal Ticket',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Mono.onDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Dashed divider rendered vertically',
                style: TextStyle(fontSize: 12, color: Mono.blueSoft),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleStat(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Mono.onDarkMuted),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Mono.onDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
