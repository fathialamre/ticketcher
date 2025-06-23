import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
                  backgroundColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(22),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  rightBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    color: Colors.red.withAlpha(100),
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
                                color: Theme.of(context).colorScheme.primary,
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
                    color: Colors.green.withAlpha(100),
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
              Ticketcher.vertical(
                width: 200,
                notchRadius: 12,
                decoration: TicketcherDecoration(
                  borderRadius: TicketRadius.zero,
                  backgroundColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(22),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.arc,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    color: Colors.blue.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Colors.purple.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
                  backgroundColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(22),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.sharp,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    color: Colors.blue.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Colors.orange.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
                  backgroundColor: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(22),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  bottomBorderStyle: BorderPattern(
                    shape: BorderShape.wave,
                    height: 5,
                  ),
                  divider: TicketDivider.solid(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                  ),
                ),
                sections: [
                  Section(
                    color: Colors.blue.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VERTICAL',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Section(
                    color: Colors.deepOrange.withAlpha(100),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TICKET',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
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
