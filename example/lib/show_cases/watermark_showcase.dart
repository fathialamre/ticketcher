import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class WatermarkShowcase extends StatelessWidget {
  const WatermarkShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watermark Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Watermark Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),

            // Horizontal ticket examples
            _buildSection(
              'Horizontal Text Watermark',
              'Text watermark on horizontal ticket',
              _buildHorizontalTextWatermark(),
            ),

            _buildSection(
              'Horizontal Icon Watermark',
              'Icon watermark on horizontal ticket',
              _buildHorizontalIconWatermark(),
            ),

            // Vertical ticket examples
            _buildSection(
              'Vertical Text Watermark',
              'Text watermark on vertical ticket',
              _buildVerticalTextWatermark(),
            ),

            _buildSection(
              'Vertical Icon Watermark',
              'Icon watermark on vertical ticket',
              _buildVerticalIconWatermark(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description, Widget ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        ticket,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildHorizontalTextWatermark() {
    return Ticketcher.horizontal(
      height: 150,
      sections: [
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Concert Ticket',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Flutter Band', style: TextStyle(fontSize: 14)),
                Text('Dec 25, 2024', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SEAT',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  'A12',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: const TicketRadius(radius: 12),
        watermark: const TicketWatermark.text(
          text: 'VALID',
          opacity: 0.3,
          alignment: WatermarkAlignment.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalIconWatermark() {
    return Ticketcher.horizontal(
      height: 150,
      sections: [
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Boarding Pass',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('NYC → LAX', style: TextStyle(fontSize: 14)),
                Text('FL123', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GATE',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  'B7',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: const TicketRadius(radius: 12),
        watermark: const TicketWatermark.widget(
          widget: Icon(Icons.flight, size: 60, color: Colors.green),
          opacity: 0.2,
          alignment: WatermarkAlignment.center,
          rotation: 15,
        ),
      ),
    );
  }

  Widget _buildVerticalTextWatermark() {
    return Ticketcher(
      width: 300,
      sections: [
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Pass',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('FlutterConf 2024'),
                Text('VIP Access'),
                Text('All Areas'),
              ],
            ),
          ),
        ),
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('ID', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(
                  '001',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Colors.purple.shade50,
        border: Border.all(color: Colors.purple.shade200),
        borderRadius: const TicketRadius(radius: 12),
        watermark: const TicketWatermark.text(
          text: 'VIP',
          opacity: 0.15,
          alignment: WatermarkAlignment.center,
          rotation: 45,
          repeat: true,
          repeatSpacing: 10,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalIconWatermark() {
    return Ticketcher(
      sections: [
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Pass',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Elite Member'),
                Text('Valid: 2024'),
                Text('Benefits: All'),
              ],
            ),
          ),
        ),
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'LEVEL',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  'GOLD',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade200),
        borderRadius: const TicketRadius(radius: 12),
        watermark: const TicketWatermark.widget(
          widget: Icon(Icons.star, size: 80, color: Colors.amber),
          opacity: 0.2,
          alignment: WatermarkAlignment.center,
        ),
      ),
    );
  }
}
