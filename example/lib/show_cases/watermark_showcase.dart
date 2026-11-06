import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

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
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
                color: Mono.ink,
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
              'Horizontal Image Watermark',
              'Image watermark as a clipped background',
              _buildHorizontalImageWatermark(),
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
            fontWeight: FontWeight.w700,
            color: Mono.ink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Mono.ash),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Mono.onDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Flutter Band',
                  style: TextStyle(fontSize: 14, color: Mono.onDark),
                ),
                Text(
                  'Dec 25, 2024',
                  style: TextStyle(fontSize: 12, color: Mono.blueSoft),
                ),
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
                  style: TextStyle(fontSize: 10, color: Mono.blueSoft),
                ),
                Text(
                  'A12',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Mono.onDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: const TicketcherDecoration(
        backgroundColor: Mono.blue,
        borderRadius: TicketRadius(radius: 12),
        watermark: TicketWatermark.text(
          text: 'VALID',
          opacity: 0.3,
          alignment: WatermarkAlignment.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Mono.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalImageWatermark() {
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Mono.ink,
                  ),
                ),
                SizedBox(height: 4),
                Text('NYC → LAX', style: Mono.body),
                Text('FL123', style: Mono.caption),
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
                Text('GATE', style: TextStyle(fontSize: 10, color: Mono.ash)),
                Text(
                  'B7',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Mono.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line),
        borderRadius: const TicketRadius(radius: 12),
        // The widget (image) watermark renders as a clipped background layer
        // behind the section content, spanning the whole ticket.
        watermark: const TicketWatermark.widget(
          widget: Image(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
            ),
            fit: BoxFit.cover,
          ),
          opacity: 0.25,
          alignment: WatermarkAlignment.center,
          width: 320,
          height: 150,
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Mono.onDark,
                  ),
                ),
                SizedBox(height: 8),
                Text('FlutterConf 2024', style: TextStyle(color: Mono.onDark)),
                Text('VIP Access', style: TextStyle(color: Mono.onDarkMuted)),
                Text('All Areas', style: TextStyle(color: Mono.onDarkMuted)),
              ],
            ),
          ),
        ),
        Section(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'ID',
                  style: TextStyle(fontSize: 12, color: Mono.onDarkMuted),
                ),
                Text(
                  '001',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Mono.blueLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: const TicketcherDecoration(
        backgroundColor: Mono.black,
        borderRadius: TicketRadius(radius: 12),
        watermark: TicketWatermark.text(
          text: 'VIP',
          opacity: 0.15,
          alignment: WatermarkAlignment.center,
          rotation: 45,
          repeat: true,
          repeatSpacing: 10,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Mono.blueLight,
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Mono.ink,
                  ),
                ),
                SizedBox(height: 8),
                Text('Elite Member', style: Mono.body),
                Text('Valid: 2024', style: Mono.body),
                Text('Benefits: All', style: Mono.body),
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
                      style: TextStyle(fontSize: 12, color: Mono.ash),
                    ),
                  ],
                ),
                Text(
                  'GOLD',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Mono.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      decoration: TicketcherDecoration(
        backgroundColor: Mono.white,
        border: Border.all(color: Mono.line),
        borderRadius: const TicketRadius(radius: 12),
        watermark: const TicketWatermark.widget(
          widget: Icon(Icons.star, size: 80, color: Mono.ash),
          opacity: 0.2,
          alignment: WatermarkAlignment.center,
        ),
      ),
    );
  }
}
