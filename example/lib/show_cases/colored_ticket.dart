import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class ColoredTicket extends StatelessWidget {
  const ColoredTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colored Ticket Examples')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
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
                    color: Mono.black,
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
                              ?.copyWith(color: Mono.onDarkMuted),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Mono.blue,
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
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Valid until Dec 31, 2024',
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
              Ticketcher.vertical(
                width: 200,
                notchRadius: 12,
                decoration: TicketcherDecoration(
                  borderRadius: TicketRadius.zero,
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.black, width: 1),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.09),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(color: Mono.black, thickness: 1),
                ),
                sections: [
                  Section(
                    color: Mono.blueSoft,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Mono.blueDeep,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Mono.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.ink,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Ticketcher.vertical(
                width: 200,
                notchRadius: 12,
                decoration: TicketcherDecoration(
                  borderRadius: TicketRadius.zero,
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.black, width: 1),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.09),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.sharp,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(color: Mono.black, thickness: 1),
                ),
                sections: [
                  Section(
                    color: Mono.blue,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Mono.blueNight,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Ticketcher.vertical(
                width: 200,
                notchRadius: 12,
                decoration: TicketcherDecoration(
                  borderRadius: TicketRadius.zero,
                  backgroundColor: Mono.white,
                  border: Border.all(color: Mono.black, width: 1),
                  shadow: BoxShadow(
                    color: Mono.black.withValues(alpha: 0.09),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.wave,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(color: Mono.black, thickness: 1),
                ),
                sections: [
                  Section(
                    color: Mono.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Mono.blue,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Mono.black,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
