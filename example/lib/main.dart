import 'package:example/show_cases/colored_ticket.dart';
import 'package:example/show_cases/flight.dart';
import 'package:example/show_cases/flight_multi_section.dart';
import 'package:example/show_cases/gradient_border_ticket.dart';
import 'package:example/show_cases/gradient_card.dart';
import 'package:example/show_cases/gradient_variations.dart';
import 'package:example/show_cases/hologram_ticket.dart';
import 'package:example/show_cases/horizontal_ticket.dart';
import 'package:example/show_cases/interactive_ticket.dart';
import 'package:example/show_cases/sales_offer.dart';
import 'package:example/show_cases/social_media.dart';
import 'package:example/show_cases/stacked_ticket.dart';
import 'package:flutter/material.dart';
import 'show_cases/circle_divider.dart';
import 'show_cases/wave_divider.dart';
import 'show_cases/smooth_wave_divider.dart';

class ExampleItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget page;

  const ExampleItem({
    required this.icon,
    required this.title,
    required this.page,
    this.subtitle,
  });
}

final List<ExampleItem> examples = [
  ExampleItem(
    icon: Icons.touch_app,
    title: 'Interactive Ticket (NEW)',
    subtitle: 'Tap sections for interactions',
    page: const InteractiveTicket(),
  ),
  ExampleItem(
    icon: Icons.flight,
    title: 'Flight Card',
    page: const FlightCard(),
  ),
  ExampleItem(
    icon: Icons.flight_takeoff,
    title: 'Flight Card with Multiple Sections',
    page: const FlightCardMultiSection(),
  ),
  ExampleItem(
    icon: Icons.gradient_outlined,
    title: 'Gradient Card',
    page: const GradientCard(),
  ),
  ExampleItem(
    icon: Icons.border_color,
    title: 'Gradient Border Ticket (NEW)',
    subtitle: 'Colorful gradient borders',
    page: const GradientBorderTicket(),
  ),
  ExampleItem(
    icon: Icons.auto_awesome,
    title: 'Holographic Ticket',
    page: const HologramTicket(),
  ),
  ExampleItem(
    icon: Icons.people_outline,
    title: 'Social Media Card',
    page: const SocialMedia(),
  ),
  ExampleItem(
    icon: Icons.local_offer_outlined,
    title: 'Sales Offer',
    page: const SalesOffer(),
  ),
  ExampleItem(
    icon: Icons.circle_outlined,
    title: 'Circle Divider',
    page: const CircleDivider(),
  ),
  ExampleItem(
    icon: Icons.waves,
    title: 'Wave Divider',
    page: const WaveDivider(),
  ),
  ExampleItem(
    icon: Icons.waves_outlined,
    title: 'Smooth Wave Divider',
    page: const SmoothWaveDivider(),
  ),
  ExampleItem(
    icon: Icons.receipt_long,
    title: 'Horizontal Ticket',
    page: const HorizontalTicket(),
  ),
  ExampleItem(
    icon: Icons.color_lens_outlined,
    title: 'Colored Sections Ticket',
    page: const ColoredTicket(),
  ),
  ExampleItem(
    icon: Icons.stacked_line_chart,
    title: 'Stacked Ticket',
    page: const StackedTicket(),
  ),
  ExampleItem(
    icon: Icons.gradient,
    title: 'Gradient Variations',
    page: const GradientVariations(),
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketcher Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticketcher Examples')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.1,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        itemBuilder: (context, index) {
          return _buildExampleCard(context, examples[index]);
        },
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, ExampleItem example) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => example.page),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(example.icon, size: 32, color: Colors.deepPurple),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                example.title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              if (example.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  example.subtitle!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
