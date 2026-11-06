import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

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
                  color: Mono.blueDeep.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
                divider: TicketDivider.wave(
                  color: Mono.blueLight,
                  thickness: 1.8,
                  waveHeight: 10,
                  waveWidth: 20,
                ),
                backgroundColor: Mono.blue,
                border: Border.fromBorderSide(
                  BorderSide(color: Mono.blue, width: 2),
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
                              fontWeight: FontWeight.w800,
                              color: Mono.onDark,
                            ),
                          ),
                          Text(
                            '10% off on all orders',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Mono.blueSoft,
                            ),
                          ),
                          Icon(
                            Icons.coffee_rounded,
                            size: 100,
                            color: Mono.white,
                          ),
                          Text(
                            'Valid until 31/05/2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Mono.blueSoft,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.pin_drop,
                                size: 16,
                                color: Mono.blueSoft,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '1000 Main St, Abu-Salim, Libya',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Mono.blueSoft,
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
                          color: Mono.white,
                        ),
                        Text(
                          'Don\'t miss out!',
                          style: TextStyle(fontSize: 12, color: Mono.blueSoft),
                        ),
                        Text(
                          'Offer ends in 2 days',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Mono.onDark,
                          ),
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
