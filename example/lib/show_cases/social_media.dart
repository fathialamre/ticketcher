import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 4,
                  offset: Offset(0, 10),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'john.doe@example.com',
                                style: TextStyle(fontSize: 12),
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
                          Icons.qr_code,
                          size: 200,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text('Scan to follow', style: TextStyle(fontSize: 12)),
                        Text('@john_doe', style: TextStyle(fontSize: 12)),
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
