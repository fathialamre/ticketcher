import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class BlurEffectShowcase extends StatelessWidget {
  const BlurEffectShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blur Effects Showcase')),
      body: Container(
        // Dark backdrop so the glass has something to blur against.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Mono.black, Mono.blueNight, Mono.blueDeep],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Blur & Glassmorphism Effects',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Modern frosted glass aesthetics for premium tickets',
              style: TextStyle(color: Mono.onDarkMuted, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Backdrop Blur
            _buildSectionTitle('1. Backdrop Blur'),
            _buildTicketExample(
              title: 'Background blur effect',
              ticket: Ticketcher.vertical(
                width: double.infinity,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.white.withValues(alpha: 0.1),
                  blurEffect: const BlurEffect.backdrop(sigma: 10),
                  borderRadius: const TicketRadius(radius: 16),
                  divider: TicketDivider.dashed(
                    color: Mono.white.withValues(alpha: 0.3),
                    thickness: 1,
                  ),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ),
                sections: [
                  Section(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PREMIUM EVENT',
                          style: TextStyle(
                            color: Mono.onDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Glass Morphism',
                          style: TextStyle(
                            color: Mono.onDark,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            shadows: [
                              Shadow(
                                color: Mono.black.withValues(alpha: 0.3),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Concert Experience',
                          style: TextStyle(
                            color: Mono.onDark.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DATE',
                              style: TextStyle(
                                color: Mono.onDark.withValues(alpha: 0.6),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'Dec 25, 2024',
                              style: TextStyle(
                                color: Mono.onDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'SEAT',
                              style: TextStyle(
                                color: Mono.onDark.withValues(alpha: 0.6),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'A-12',
                              style: TextStyle(
                                color: Mono.onDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Frosted Glass
            _buildSectionTitle('2. Frosted Glass'),
            _buildTicketExample(
              title: 'Blur with tinted overlay',
              ticket: Ticketcher.vertical(
                width: double.infinity,
                decoration: TicketcherDecoration(
                  backgroundColor: Colors.transparent,
                  blurEffect: BlurEffect.frosted(
                    sigma: 15,
                    tintColor: Mono.white,
                    opacity: 0.15,
                  ),
                  borderRadius: const TicketRadius(radius: 16),
                  border: Border.all(
                    color: Mono.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  divider: TicketDivider.smoothWave(
                    color: Mono.white.withValues(alpha: 0.3),
                    thickness: 2,
                  ),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ),
                sections: [
                  Section(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Mono.blue.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Mono.blueLight.withValues(alpha: 0.6),
                            ),
                          ),
                          child: const Text(
                            'VIP ACCESS',
                            style: TextStyle(
                              color: Mono.onDark,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Frosted Elegance',
                          style: TextStyle(
                            color: Mono.onDark,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Winter Gala 2024',
                          style: TextStyle(
                            color: Mono.onDark.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Expanded(child: _buildInfoCard('TIME', '8:00 PM')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInfoCard('GATE', 'B7')),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Gaussian Blur
            _buildSectionTitle('3. Gaussian Blur'),
            _buildTicketExample(
              title: 'Content blur effect',
              ticket: Ticketcher.horizontal(
                height: 180,
                decoration: TicketcherDecoration(
                  backgroundColor: Mono.white.withValues(alpha: 0.9),
                  blurEffect: const BlurEffect.gaussian(sigma: 3),
                  borderRadius: const TicketRadius(radius: 12),
                  divider: TicketDivider.circles(
                    color: Mono.blue.withValues(alpha: 0.3),
                    circleRadius: 3,
                    thickness: 1.5,
                  ),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SOFT FOCUS',
                          style: TextStyle(
                            color: Mono.blue,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Dreamy Vibes',
                          style: TextStyle(
                            color: Mono.ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Mono.blue, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Skyline Venue',
                              style: TextStyle(color: Mono.ash, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Section(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_2, color: Mono.ink, size: 60),
                        const SizedBox(height: 8),
                        Text(
                          '#GT2024',
                          style: TextStyle(
                            color: Mono.ash,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Mono.onDark,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildTicketExample({required String title, required Widget ticket}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              color: Mono.onDark.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
        ),
        ticket,
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Mono.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Mono.onDark.withValues(alpha: 0.7),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Mono.onDark,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
