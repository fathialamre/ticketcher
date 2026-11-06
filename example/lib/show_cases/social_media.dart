import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Media Card')),
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
                  shape: BorderShape.sharp,
                ),
                shadow: BoxShadow(
                  color: Mono.blue,
                  blurRadius: 4,
                  offset: Offset(0, 10),
                ),

                backgroundColor: Mono.black,
                border: Border.fromBorderSide(
                  BorderSide(color: Mono.black, width: 2),
                ),
              ),

              sections: [
                Section(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Mono.blue,
                            child: Icon(Icons.person, color: Mono.white),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Mono.onDark,
                                ),
                              ),
                              Text(
                                'john.doe@example.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Mono.onDarkMuted,
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
                        Icon(Icons.qr_code, size: 200, color: Mono.white),
                        Text(
                          'Scan to follow',
                          style: TextStyle(
                            fontSize: 12,
                            color: Mono.onDarkMuted,
                          ),
                        ),
                        Text(
                          '@john_doe',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Mono.blueLight,
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
