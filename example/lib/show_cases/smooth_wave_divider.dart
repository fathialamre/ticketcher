import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class SmoothWaveDivider extends StatelessWidget {
  const SmoothWaveDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smooth Wave Divider Card')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Ticketcher(
                  notchRadius: 18,
                  decoration: TicketcherDecoration(
                    borderRadius: TicketRadius(
                      radius: 20,
                      corner: TicketCorner.all,
                    ),

                    shadow: BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                    divider: TicketDivider.smoothWave(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 2,
                      waveHeight: 6,
                      waveWidth: 12,
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inversePrimary,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  sections: [
                    Section(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smooth Wave Divider Example',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'This example shows how to use smooth wave dividers between sections.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Section(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Features',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Smooth curved waves using Bezier curves\n• Customizable wave height and width\n• Perfect distribution across the width',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Section(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Use TicketDivider.smoothWave() to create beautiful smooth wave dividers between sections.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
