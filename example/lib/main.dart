import 'package:example/show_cases/flight.dart';
import 'package:example/show_cases/flight_multi_section.dart';
import 'package:example/show_cases/gradient_card.dart';
import 'package:example/show_cases/horizontal_ticket.dart';
import 'package:example/show_cases/sales_offer.dart';
import 'package:example/show_cases/social_media.dart';
import 'package:flutter/material.dart';
import 'show_cases/circle_divider.dart';
import 'show_cases/wave_divider.dart';
import 'show_cases/smooth_wave_divider.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.flight),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Flight Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FlightCard()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.flight_takeoff),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Flight Card with Multiple Sections'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlightCardMultiSection(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.gradient_outlined),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Gradient Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GradientCard()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people_outline),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Social Media Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_offer_outlined),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Sales Offer Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalesOffer()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.circle_outlined),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Circle Divider Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CircleDivider(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.waves),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Wave Divider Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaveDivider()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.waves_outlined),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Smooth Wave Divider Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SmoothWaveDivider(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              title: const Text('Horizontal Ticket'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HorizontalTicket(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
