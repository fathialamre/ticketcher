import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

/// A showcase demonstrating the image background feature for tickets.
///
/// This example demonstrates:
/// - Global ticket image backgrounds with different fit modes
/// - Per-section image backgrounds
/// - Image opacity control
/// - Combining images with text and other content
/// - Mixing section images with decoration images
class ImageBackgroundShowcase extends StatelessWidget {
  const ImageBackgroundShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Background Showcase'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Example 1: Global ticket background image
            _buildSectionTitle('1. Global Ticket Background'),
            _buildDescription(
              'A ticket with a global background image covering the entire ticket.',
            ),
            const SizedBox(height: 12),
            Ticketcher(
              width: double.infinity,
              notchRadius: 12,
              decoration: TicketcherDecoration(
                borderRadius: const TicketRadius(radius: 16),
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1557683316-973673baf926',
                ),
                backgroundImageFit: BoxFit.cover,
                backgroundImageOpacity: 0.7,
                border: Border.all(color: Colors.white, width: 2),
                divider: TicketDivider.dashed(
                  color: Colors.white,
                  thickness: 1.5,
                  dashWidth: 8,
                  dashSpace: 6,
                ),
                shadow: BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ),
              sections: [
                Section(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Summer Festival 2025',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'VIP Access',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn('Date', 'Aug 15, 2025', Colors.white),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      _buildInfoColumn('Time', '7:00 PM', Colors.white),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      _buildInfoColumn('Gate', 'A12', Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Example 2: Per-section background images
            _buildSectionTitle('2. Per-Section Background Images'),
            _buildDescription(
              'Different background images for each section with varying opacity.',
            ),
            const SizedBox(height: 12),
            Ticketcher(
              width: double.infinity,
              notchRadius: 12,
              decoration: TicketcherDecoration(
                borderRadius: const TicketRadius(radius: 16),
                backgroundColor: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300, width: 2),
                divider: TicketDivider.circles(
                  color: Colors.grey.shade400,
                  circleRadius: 3,
                  circleSpacing: 6,
                ),
              ),
              sections: [
                Section(
                  padding: const EdgeInsets.all(24),
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
                  ),
                  backgroundImageFit: BoxFit.cover,
                  backgroundImageOpacity: 0.8,
                  child: const Column(
                    children: [
                      Text(
                        'Mountain Adventure',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black87, blurRadius: 6),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Experience the peaks',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(24),
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1464037866556-6812c9d1c72e',
                  ),
                  backgroundImageFit: BoxFit.cover,
                  backgroundImageOpacity: 0.6,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.landscape,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Ticket #A12345',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Example 3: Different BoxFit modes
            _buildSectionTitle('3. Image Fit Modes'),
            _buildDescription(
              'Demonstrating BoxFit.contain vs BoxFit.cover with a wide image.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Ticketcher(
                    notchRadius: 10,
                    decoration: TicketcherDecoration(
                      borderRadius: const TicketRadius(radius: 12),
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1502134249126-9f3755a50d78',
                      ),
                      backgroundImageFit: BoxFit.contain,
                      backgroundColor: Colors.grey.shade800,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    sections: [
                      const Section(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Contain',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Section(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Full Image\nVisible',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Ticketcher(
                    notchRadius: 10,
                    decoration: TicketcherDecoration(
                      borderRadius: const TicketRadius(radius: 12),
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1502134249126-9f3755a50d78',
                      ),
                      backgroundImageFit: BoxFit.cover,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    sections: [
                      const Section(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Cover',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black87, blurRadius: 4),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Section(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Fills\nSpace',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black87, blurRadius: 4),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Example 4: Opacity variations
            _buildSectionTitle('4. Image Opacity Control'),
            _buildDescription(
              'Same image with different opacity levels (0.3, 0.6, 1.0).',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildOpacityExample(0.3)),
                const SizedBox(width: 12),
                Expanded(child: _buildOpacityExample(0.6)),
                const SizedBox(width: 12),
                Expanded(child: _buildOpacityExample(1.0)),
              ],
            ),
            const SizedBox(height: 32),

            // Example 5: Mixed backgrounds
            _buildSectionTitle('5. Mixed Backgrounds'),
            _buildDescription(
              'Combining decoration image with section colors and gradients.',
            ),
            const SizedBox(height: 12),
            Ticketcher(
              width: double.infinity,
              notchRadius: 12,
              decoration: TicketcherDecoration(
                borderRadius: const TicketRadius(radius: 16),
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1542831371-29b0f74f9713',
                ),
                backgroundImageFit: BoxFit.cover,
                backgroundImageOpacity: 0.4,
                border: Border.all(color: Colors.blueGrey.shade700, width: 2),
                divider: TicketDivider.smoothWave(
                  color: Colors.white,
                  thickness: 2,
                  waveHeight: 6,
                  waveWidth: 10,
                ),
              ),
              sections: [
                Section(
                  padding: const EdgeInsets.all(24),
                  color: Colors.deepPurple.withOpacity(0.8),
                  child: const Column(
                    children: [
                      Icon(Icons.code, size: 48, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Developer Conference',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: const EdgeInsets.all(24),
                  color: Colors.teal.withOpacity(0.8),
                  child: const Column(
                    children: [
                      Text(
                        'Section with Solid Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Background image is behind this',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
    );
  }

  Widget _buildInfoColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: const [Shadow(color: Colors.black54, blurRadius: 3)],
          ),
        ),
      ],
    );
  }

  Widget _buildOpacityExample(double opacity) {
    return Ticketcher(
      notchRadius: 8,
      decoration: TicketcherDecoration(
        borderRadius: const TicketRadius(radius: 10),
        backgroundImage: const NetworkImage(
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97',
        ),
        backgroundImageFit: BoxFit.cover,
        backgroundImageOpacity: opacity,
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
      ),
      sections: [
        Section(
          padding: const EdgeInsets.all(12),
          child: Text(
            '${(opacity * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Section(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.image, color: Colors.white, size: 24),
        ),
      ],
    );
  }
}
