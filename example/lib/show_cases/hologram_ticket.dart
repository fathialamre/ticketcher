import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class HologramTicket extends StatelessWidget {
  const HologramTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Holographic Ticket')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Ticketcher.vertical(
            width: 280,
            notchRadius: 15,
            decoration: TicketcherDecoration(
              borderRadius: const TicketRadius(
                radius: 20,
                corner: TicketCorner.top,
              ),
              // Iridescent foil: blue and white bands sweeping across the face
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Mono.blueSoft,
                  Mono.white,
                  Mono.blueLight,
                  Mono.fog,
                  Mono.blueTint,
                  Mono.blueLight,
                  Mono.white,
                  Mono.blueSoft,
                ],
                stops: [0.0, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 1.0],
              ),
              shadow: BoxShadow(
                color: Mono.blue.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 5,
              ),
              bottomBorderStyle: BorderPattern(
                shape: BorderShape.arc,
                height: 8,
              ),
              divider: TicketDivider.dashed(
                color: Mono.blueDeep.withValues(alpha: 0.6),
                thickness: 1.5,
                dashWidth: 8,
                dashSpace: 4,
              ),
            ),
            sections: [
              // Header section
              Section(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Mono.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'X3A',
                        style: TextStyle(
                          color: Mono.onDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '438948',
                      style: TextStyle(
                        color: Mono.ink,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const Text(
                      'DRAMA',
                      style: TextStyle(
                        color: Mono.ink,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        height: 0.9,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'New Year\n2022',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Mono.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'BOARDING PASS*',
                      style: TextStyle(
                        color: Mono.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              // Details section
              Section(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DATE',
                              style: TextStyle(
                                color: Mono.ink.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              '08/04',
                              style: TextStyle(
                                color: Mono.ink,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'CABIN',
                              style: TextStyle(
                                color: Mono.ink.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              'TOURIST CLASS',
                              style: TextStyle(
                                color: Mono.ink,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PASSENGER',
                              style: TextStyle(
                                color: Mono.ink.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              'SPT',
                              style: TextStyle(
                                color: Mono.ink,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.flight, color: Mono.ink, size: 32),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Barcode representation
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Mono.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: List.generate(
                          35,
                          (index) => Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: index % 3 == 0 ? 1 : 0.5,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Mono.white,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        '640509 040147',
                        style: TextStyle(
                          color: Mono.ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
