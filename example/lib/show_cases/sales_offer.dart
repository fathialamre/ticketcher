import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class SalesOffer extends StatelessWidget {
  const SalesOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Offer Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ticketcher(
              notchRadius: 0,
              decoration: TicketcherDecoration(
                borderRadius: TicketRadius(
                  radius: 20,
                  corner: TicketCorner.top,
                ),
                bottomBorderStyle: BorderPattern(
                  height: 18,
                  shape: BorderShape.wave,
                ),
                shadow: BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
                divider: TicketDivider.wave(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1.8,
                  waveHeight: 10,
                  waveWidth: 20,
                ),
                backgroundColor: Theme.of(context).cardColor,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),

              sections: [
                Section(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Coffee Shop',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Text(
                            '10% off on all orders',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Icon(
                            Icons.coffee_rounded,
                            size: 100,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Text(
                            'Valid until 31/05/2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.pin_drop,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '1000 Main St, Abu-Salim, Libya',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: EdgeInsets.all(4),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 180,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          'Don\'t miss out!',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Offer ends in 2 days',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
