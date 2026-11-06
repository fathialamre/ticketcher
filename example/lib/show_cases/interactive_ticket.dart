import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class InteractiveTicket extends StatefulWidget {
  const InteractiveTicket({super.key});

  @override
  State<InteractiveTicket> createState() => _InteractiveTicketState();
}

class _InteractiveTicketState extends State<InteractiveTicket> {
  String _selectedSection = 'None';
  int _tapCount = 0;
  String _lastTappedAction = '';

  void _showSectionTapped(String sectionName) {
    setState(() {
      _selectedSection = sectionName;
      _tapCount++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$sectionName section tapped!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _performAction(String action) {
    setState(() {
      _lastTappedAction = action;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Action: $action'),
        duration: const Duration(seconds: 2),
        backgroundColor: Mono.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Ticket')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: Mono.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interaction Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Mono.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Last tapped section: $_selectedSection',
                      style: Mono.body,
                    ),
                    Text(
                      'Total taps: $_tapCount',
                      style: Mono.body.copyWith(
                        color: Mono.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (_lastTappedAction.isNotEmpty)
                      Text('Last action: $_lastTappedAction', style: Mono.body),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Vertical Interactive Ticket
            const Text(
              'Vertical Interactive Ticket',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Mono.ink,
              ),
            ),
            const SizedBox(height: 10),

            Ticketcher(
              width: double.infinity,
              decoration: TicketcherDecoration(
                borderRadius: TicketRadius(
                  radius: 12,
                  corner: TicketCorner.all,
                ),
                backgroundColor: Mono.white,
                border: Border.all(color: Mono.black, width: 2),
                divider: TicketDivider.dotted(
                  color: Mono.blue,
                  thickness: 2,
                  dotSize: 4,
                  dotSpacing: 8,
                ),
                shadow: BoxShadow(
                  color: Mono.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ),
              sections: [
                Section(
                  padding: const EdgeInsets.all(20),
                  onTap: () => _showSectionTapped('Header'),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.airplane_ticket,
                        size: 50,
                        color: Mono.blue,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Flight Ticket',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Mono.ink,
                        ),
                      ),
                      const Text('Tap to view details', style: Mono.caption),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(20),
                  onTap: () => _showSectionTapped('Flight Info'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('From', style: Mono.caption),
                          const Text(
                            'NYC',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Mono.ink,
                            ),
                          ),
                          const Text('9:00 AM', style: Mono.body),
                        ],
                      ),
                      const Icon(Icons.flight, color: Mono.blue),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('To', style: Mono.caption),
                          const Text(
                            'LAX',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Mono.ink,
                            ),
                          ),
                          const Text('12:30 PM', style: Mono.body),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(20),
                  onTap: () => _performAction('Check-in'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Mono.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'TAP TO CHECK-IN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Mono.onDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Horizontal Interactive Ticket
            const Text(
              'Horizontal Interactive Ticket',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Mono.ink,
              ),
            ),
            const SizedBox(height: 10),

            Ticketcher.horizontal(
              height: 200,
              decoration: TicketcherDecoration(
                borderRadius: TicketRadius(
                  radius: 12,
                  corner: TicketCorner.all,
                ),
                backgroundColor: Mono.black,
                border: Border.all(color: Mono.blue, width: 2),
                divider: TicketDivider.doubleLine(
                  color: Mono.blueLight,
                  thickness: 1,
                  lineSpacing: 4,
                ),
                shadow: BoxShadow(
                  color: Mono.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ),
              sections: [
                Section(
                  widthFactor: 2,
                  padding: const EdgeInsets.all(16),
                  onTap: () => _showSectionTapped('Event Info'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CONCERT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.8,
                          color: Mono.blueLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rock Festival 2024',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Mono.onDark,
                        ),
                      ),
                      const Text(
                        'December 25, 2024',
                        style: TextStyle(color: Mono.onDarkMuted),
                      ),
                      const Text(
                        'Stadium Arena',
                        style: TextStyle(color: Mono.onDarkMuted),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap for details',
                        style: TextStyle(
                          fontSize: 12,
                          color: Mono.blueLight,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(16),
                  onTap: () => _performAction('Show QR Code'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code, size: 80, color: Mono.onDark),
                      const SizedBox(height: 8),
                      const Text(
                        'QR CODE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Mono.blueLight,
                        ),
                      ),
                      const Text(
                        'Tap to scan',
                        style: TextStyle(fontSize: 10, color: Mono.onDarkMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Instructions
            Card(
              color: Mono.blueTint,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Mono.blue),
                        SizedBox(width: 8),
                        Text(
                          'How to use',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Mono.blueDeep,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Tap on any section of the tickets above\n'
                      '• Each section has its own onTap callback\n'
                      '• Watch the status update and snackbar messages\n'
                      '• Sections show visual feedback when tapped',
                      style: Mono.body,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
