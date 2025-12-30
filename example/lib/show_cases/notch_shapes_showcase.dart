import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class NotchShapesShowcase extends StatelessWidget {
  const NotchShapesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notch Shape Variations'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Semicircle Notch (Default)'),
            _buildTicketWithNotch(
              context,
              notchStyle: const NotchStyle.semicircle(radius: 12),
              color: Colors.deepPurple,
              description: 'Classic circular notch shape',
              shapeName: 'Semicircle',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Triangle Notch'),
            _buildTicketWithNotch(
              context,
              notchStyle: const NotchStyle.triangle(radius: 14),
              color: Colors.teal,
              description: 'Sharp triangular cutouts',
              shapeName: 'Triangle',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Square Notch'),
            _buildTicketWithNotch(
              context,
              notchStyle: const NotchStyle.square(radius: 10),
              color: Colors.orange,
              description: 'Clean square-shaped notches',
              shapeName: 'Square',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Diamond Notch'),
            _buildTicketWithNotch(
              context,
              notchStyle: const NotchStyle.diamond(radius: 12),
              color: Colors.pink,
              description: 'Elegant diamond-shaped cutouts',
              shapeName: 'Diamond',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Horizontal Ticket with Triangle Notch'),
            _buildHorizontalTicketWithNotch(context),
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
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTicketWithNotch(
    BuildContext context, {
    required NotchStyle notchStyle,
    required Color color,
    required String description,
    required String shapeName,
  }) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        notchStyle: notchStyle,
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Colors.white,
        border: Border.all(color: color.withAlpha(77), width: 1.5),
        divider: TicketDivider.dashed(
          color: color.withAlpha(128),
          thickness: 1.5,
          dashWidth: 8,
          dashSpace: 4,
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
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForNotch(notchStyle.shape),
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shapeName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Radius',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  Text(
                    '${notchStyle.radius.toInt()}px',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'PREVIEW',
                  style: TextStyle(
                    color: Colors.white,
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

  Widget _buildHorizontalTicketWithNotch(BuildContext context) {
    return Ticketcher.horizontal(
      decoration: TicketcherDecoration(
        notchStyle: const NotchStyle.triangle(radius: 12),
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.withAlpha(77), width: 1.5),
        divider: TicketDivider.dashed(
          color: Colors.indigo.withAlpha(128),
          thickness: 1.5,
        ),
      ),
      sections: [
        Section(
          widthFactor: 0.35,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.confirmation_number, color: Colors.indigo, size: 36),
              SizedBox(height: 8),
              Text(
                'ADMIT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'ONE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
        Section(
          widthFactor: 0.65,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Triangle Notch',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Horizontal ticket with triangle-shaped notches',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForNotch(NotchShape shape) {
    switch (shape) {
      case NotchShape.semicircle:
        return Icons.circle_outlined;
      case NotchShape.triangle:
        return Icons.change_history;
      case NotchShape.square:
        return Icons.crop_square;
      case NotchShape.diamond:
        return Icons.diamond_outlined;
    }
  }
}
