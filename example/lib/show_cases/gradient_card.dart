import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gradient Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ticketcher(
              notchRadius: 18,
              decoration: TicketcherDecoration(
                borderRadius: TicketRadius(
                  radius: 20,
                  corner: TicketCorner.top,
                ),
                bottomBorderStyle: BorderPattern(
                  height: 10,
                  shape: BorderShape.arc,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Mono.blue, Mono.black, Mono.blueDeep],
                ),
                shadow: BoxShadow(
                  color: Mono.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
                divider: TicketDivider.dashed(
                  color: Mono.white.withValues(alpha: 0.35),
                  thickness: 1.8,
                  dashWidth: 8,
                  dashSpace: 0.01,
                ),
                backgroundColor: Mono.white,
                border: Border.fromBorderSide(
                  BorderSide(color: Mono.line, width: 2),
                ),
              ),
              sections: [
                Section(
                  padding: EdgeInsets.all(20),
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
                              color: Mono.onDark,
                            ),
                          ),
                          Text(
                            '10% off on all orders',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Mono.onDark,
                            ),
                          ),
                          Icon(
                            Icons.coffee_rounded,
                            size: 100,
                            color: Mono.onDark,
                          ),
                          Text(
                            'Valid until 31/05/2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Mono.onDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  padding: EdgeInsets.all(20),
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
                              color: Mono.onDark,
                            ),
                          ),
                          Text(
                            '10% off on all orders',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Mono.onDark,
                            ),
                          ),
                          Icon(
                            Icons.coffee_rounded,
                            size: 100,
                            color: Mono.onDark,
                          ),
                          Text(
                            'Valid until 31/05/2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Mono.onDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.pin_drop,
                                size: 16,
                                color: Mono.onDark,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '1000 Main St, Abu-Salim, Libya',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Mono.onDark,
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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 180,
                          color: Mono.onDark,
                        ),
                        Text(
                          'Don\'t miss out!',
                          style: TextStyle(fontSize: 12, color: Mono.onDark),
                        ),
                        Text(
                          'Offer ends in 2 days',
                          style: TextStyle(fontSize: 12, color: Mono.onDark),
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
