import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class CircleDivider extends StatelessWidget {
  const CircleDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Divider Card')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Ticketcher(
                  notchRadius: 12,
                  decoration: TicketcherDecoration(
                    borderRadius: TicketRadius(
                      radius: 20,
                      corner: TicketCorner.all,
                    ),

                    shadow: BoxShadow(
                      color: Mono.blue,
                      blurRadius: 3,
                      offset: Offset(12, 10),
                    ),
                    divider: TicketDivider.circles(
                      color: Mono.blueLight,
                      thickness: 2,
                      circleRadius: 2,
                      circleSpacing: 10,
                    ),
                    backgroundColor: Mono.white,
                    border: Border.fromBorderSide(
                      BorderSide(color: Mono.black, width: 2),
                    ),
                  ),
                  sections: [
                    Section(
                      color: Mono.black,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Circle Divider Example',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Mono.onDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'This example shows how to use circle dividers between sections.',
                            style: TextStyle(color: Mono.onDarkMuted),
                          ),
                        ],
                      ),
                    ),
                    Section(
                      color: Mono.white,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Features',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Mono.ink,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Customizable circle radius\n• Adjustable spacing between circles\n• Smooth integration with other ticket features',
                            style: TextStyle(color: Mono.ash),
                          ),
                        ],
                      ),
                    ),
                    Section(
                      color: Mono.blue,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Mono.onDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Use TicketDivider.circles() to create beautiful circle dividers between sections.',
                            style: TextStyle(color: Mono.blueSoft),
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
