import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class AdvancedDividersShowcase extends StatelessWidget {
  const AdvancedDividersShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Dividers'),
        backgroundColor: Colors.cyan[700],
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0F4F8),
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
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSolidDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.cyan[300]!, width: 1.5),
        divider: TicketDivider.solid(color: Colors.cyan[300]!, thickness: 2),
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
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.horizontal_rule,
                  color: Colors.cyan[700],
                  size: 28,
                ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Clean straight line divider',
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
              Text(
                'Simple and elegant',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SOLID',
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

  Widget _buildDashedDividerTicket(BuildContext context) {
    return Ticketcher(
      decoration: TicketcherDecoration(
        borderRadius: TicketRadius(radius: 16, corner: TicketCorner.all),
        backgroundColor: const Color(0xFFFFF8E1),
        border: Border.all(color: Colors.orange[400]!, width: 1.5),
        divider: TicketDivider.dashed(
          color: Colors.orange[400]!,
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
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'COUPON',
                      style: TextStyle(
                        color: Colors.white,
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
                style: TextStyle(fontSize: 14, color: Colors.black54),
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
                    'CODE',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                      letterSpacing: 1,
                    ),
                  ),
                  const Text(
                    'SAVE20',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              Text(
                'Dashed divider',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange[700],
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
        backgroundColor: const Color(0xFF1A1A2E),
        border: Border.all(color: Colors.purple[400]!, width: 1.5),
        divider: TicketDivider.circles(
          color: Colors.purple[400]!,
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
                  gradient: LinearGradient(
                    colors: [Colors.purple[400]!, Colors.pink[400]!],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Beautiful circular pattern',
                      style: TextStyle(fontSize: 13, color: Colors.white60),
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
              _buildCircleStat('Radius', '4px', Colors.purple[400]!),
              _buildCircleStat('Spacing', '12px', Colors.pink[400]!),
              _buildCircleStat('Style', 'Filled', Colors.orange[400]!),
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
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.teal[400]!, width: 1.5),
        divider: TicketDivider.wave(
          color: Colors.teal[400]!,
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
                  gradient: LinearGradient(
                    colors: [Colors.teal[300]!, Colors.cyan[300]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.waves, color: Colors.white, size: 28),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Smooth wave pattern divider',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
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
              Text(
                'Height: 4px • Width: 16px',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.teal, Colors.cyan]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'WAVE',
                  style: TextStyle(
                    color: Colors.white,
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
        gradient: LinearGradient(
          colors: [Colors.indigo[400]!, Colors.purple[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.indigo[400]!, width: 1.5),
        divider: TicketDivider.dashed(
          color: Colors.white54,
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
              Icon(Icons.more_vert, color: Colors.white, size: 32),
              SizedBox(height: 8),
              Text(
                'VERTICAL',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'DASHED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Dashed divider rendered vertically',
                style: TextStyle(fontSize: 12, color: Colors.white70),
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
          style: const TextStyle(fontSize: 10, color: Colors.white54),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
