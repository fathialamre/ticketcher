import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Ticket'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interaction Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Last tapped section: $_selectedSection'),
                    Text('Total taps: $_tapCount'),
                    if (_lastTappedAction.isNotEmpty)
                      Text('Last action: $_lastTappedAction'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Vertical Interactive Ticket
            Text(
              'Vertical Interactive Ticket',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
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
                backgroundColor: Colors.white,
                border: Border.all(color: Colors.deepPurple, width: 2),
                divider: TicketDivider.dotted(
                  color: Colors.deepPurple,
                  thickness: 2,
                  dotSize: 4,
                  dotSpacing: 8,
                ),
                shadow: BoxShadow(
                  color: Colors.grey.shade300,
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
                      Icon(
                        Icons.airplane_ticket,
                        size: 50,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Flight Ticket',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        'Tap to view details',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
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
                          Text('From', style: TextStyle(color: Colors.grey)),
                          Text(
                            'NYC',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('9:00 AM'),
                        ],
                      ),
                      Icon(Icons.flight, color: Colors.deepPurple),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('To', style: TextStyle(color: Colors.grey)),
                          Text(
                            'LAX',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('12:30 PM'),
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
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'TAP TO CHECK-IN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Horizontal Interactive Ticket
            Text(
              'Horizontal Interactive Ticket',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
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
                backgroundColor: Colors.white,
                border: Border.all(color: Colors.orange, width: 2),
                divider: TicketDivider.doubleLine(
                  color: Colors.orange,
                  thickness: 1,
                  lineSpacing: 4,
                ),
                shadow: BoxShadow(
                  color: Colors.grey.shade300,
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
                      Text(
                        'CONCERT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rock Festival 2024',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'December 25, 2024',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        'Stadium Arena',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap for details',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
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
                      Icon(Icons.qr_code, size: 80, color: Colors.orange),
                      const SizedBox(height: 8),
                      Text(
                        'QR CODE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'Tap to scan',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Instructions
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'How to use',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Tap on any section of the tickets above\n'
                      '• Each section has its own onTap callback\n'
                      '• Watch the status update and snackbar messages\n'
                      '• Sections show visual feedback when tapped',
                      style: TextStyle(fontSize: 14),
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
