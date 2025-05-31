import 'package:example/show_cases/flight.dart';
import 'package:example/show_cases/gradient_card.dart';
import 'package:example/show_cases/sales_offer.dart';
import 'package:example/show_cases/social_media.dart';
import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      debugShowCheckedModeBanner: false,
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlightCard()),
                );
              },
              child: const Text('Flight Card'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialMedia()),
                );
              },
              child: const Text('Social Media Card'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesOffer()),
                );
              },
              child: const Text('Sales Offer Card'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GradientCard()),
                );
              },
              child: const Text('Gradient Card'),
            ),
          ],
        ),
      ),
    );
  }
}
