import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class HorizontalTicket extends StatelessWidget {
  const HorizontalTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horizontal Ticket Examples')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),

              // First Ticket - Discount Coupon
              Ticketcher.horizontal(
                height: 160,
                notchRadius: 12,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 16),
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.black, width: 1),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.09),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(color: Mono.black, thickness: 1),
                ),
                sections: [
                  Section(
                    color: Mono.blue,
                    widthFactor: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '50% OFF',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'On your next purchase',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Mono.blueSoft),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Mono.white,
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CODE: SAVE50',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.ink,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Valid until Dec 31, 2024',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Mono.ash),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Second Ticket - Movie Ticket
              Ticketcher.horizontal(
                height: 140,
                notchRadius: 8,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 12),
                  backgroundColor: Mono.blueNight,
                  gradient: Mono.gradientNight,
                  border: Border.all(color: Mono.blueNight, width: 1.5),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 4,
                  ),
                  divider: TicketDivider.smoothWave(
                    color: Mono.blueLight,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 1.2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AVATAR 2',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'IMAX 3D',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Mono.blueSoft,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Row: G, Seat: 12',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Today, 7:30 PM',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Mono.blueSoft),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Screen 3',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Mono.blueSoft),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Third Ticket - Event Pass
              Ticketcher.horizontal(
                height: 140,
                notchRadius: 10,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 14),
                  backgroundColor: Mono.black,
                  border: Border.all(color: Mono.graphite, width: 1.5),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.solid(
                    color: Mono.graphite,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VIP PASS',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tech Conference',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Mono.blueLight),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Access All Areas',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Mono.onDarkMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fourth Ticket - Concert Ticket
              Ticketcher.horizontal(
                height: 170,
                notchRadius: 10,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 14),
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.line, width: 1.5),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  leftBorderStyle: BorderPattern(
                    shape: BorderShape.wave,
                    height: 11,
                    width: 7,
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 12,
                  ),
                  divider: TicketDivider.wave(
                    color: Mono.line,
                    thickness: 1,
                    waveHeight: 4,
                    waveWidth: 14,
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section A, Row 15',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.ink,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'June 15, 2024 • 8:00 PM',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Mono.ink),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Madison Square Garden',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Mono.ash),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    widthFactor: 1.2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLDPLAY',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Mono.blue,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fourth Ticket - Concert Ticket with Dotted Divider
              Ticketcher.horizontal(
                height: 140,
                notchRadius: 10,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 14),
                  backgroundColor: Mono.blue,
                  border: Border.all(color: Mono.blue, width: 1.5),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.circles(
                    color: Mono.blueLight,
                    thickness: 2,
                    circleRadius: 2,
                    circleSpacing: 8,
                    padding: 8,
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ROCK FEST',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Summer Tour 2024',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Mono.blueSoft),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VIP Access',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Backstage Pass',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Mono.blueSoft),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Fifth Ticket - Train Ticket with Double Line Divider
              Ticketcher.horizontal(
                height: 140,
                notchRadius: 10,
                decoration: TicketcherDecoration(
                  borderRadius: const TicketRadius(radius: 14),
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.black, width: 1.5),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.solid(
                    color: Mono.line,
                    thickness: 1.5,
                    padding: 8,
                  ),
                ),
                sections: [
                  Section(
                    widthFactor: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXPRESS',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Mono.blue,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'First Class',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Mono.ash),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    widthFactor: 2,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Platform 9¾',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.ink,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Departure: 11:00 AM',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Mono.ash),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
