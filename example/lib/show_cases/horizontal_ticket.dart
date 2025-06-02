import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.red.shade300, width: 2),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(22),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 5,
                  ),
                  divider: TicketDivider.dashed(
                    color: Colors.grey,
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
                          '50% OFF',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'On your next purchase',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade700),
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
                          'CODE: SAVE50',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Valid until Dec 31, 2024',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade600),
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
                  backgroundColor: Colors.white,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1a2a6c),
                      Color(0xFFb21f1f),
                      Color(0xFFfdbb2d),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.indigo.shade200, width: 1.5),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 4,
                  ),
                  divider: TicketDivider.circles(
                    color: Colors.white,
                    thickness: 1,
                    circleRadius: 3,
                    circleSpacing: 8,
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'IMAX 3D',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white,
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
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Today, 7:30 PM',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Screen 3',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white),
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
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.green.shade300, width: 1.5),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.solid(
                    color: Colors.green,
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
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tech Conference',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.green.shade700),
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
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Access All Areas',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.green.shade600),
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
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.purple.shade300, width: 1.5),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(20),
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
                    color: Colors.purple,
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
                                color: Colors.purple.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'June 15, 2024 • 8:00 PM',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.purple.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Madison Square Garden',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.purple.shade600),
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
                                color: Colors.purple.shade800,
                                fontWeight: FontWeight.bold,
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
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.purple.shade300, width: 1.5),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.dotted(
                    color: Colors.purple,
                    thickness: 2,
                    dotSize: 2,
                    dotSpacing: 8,
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
                                color: Colors.purple.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Summer Tour 2024',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.purple.shade700),
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
                                color: Colors.purple.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Backstage Pass',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.purple.shade700),
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
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.blue.shade300, width: 1.5),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 6,
                  ),
                  divider: TicketDivider.doubleLine(
                    color: Colors.blue,
                    thickness: 1.5,
                    lineSpacing: 4,
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
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'First Class',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.blue.shade700),
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
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Departure: 11:00 AM',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.blue.shade700),
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
