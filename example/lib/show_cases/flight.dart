import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flight Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: List.generate(10, (index) => FlightWidget()),
            ),
          ),
        ),
      ),
    );
  }
}

class FlightWidget extends StatelessWidget {
  const FlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, left: 4, right: 4, top: 4),
      child: Ticketcher(
        onTap: () {
          print('ticket taping');
        },
        decoration: TicketcherDecoration(
          borderRadius: TicketRadius(radius: 20, corner: TicketCorner.top),
          backgroundColor: Mono.white,
          border: Border.all(color: Mono.black, width: 2),
          shadow: BoxShadow(
            color: Mono.black,
            blurRadius: 3,
            offset: Offset(0, 10),
          ),
          divider: TicketDivider.dashed(
            color: Mono.line,
            thickness: 1,
            padding: 8,
          ),
          bottomBorderStyle: BorderPattern(height: 10, shape: BorderShape.wave),
        ),
        sections: [
          // Header section
          Section(
            onTap: () {
              print('section tap');
            },
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Mono.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.airplanemode_active, color: Mono.blueLight),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Libyan Airways",
                              style: TextStyle(
                                fontSize: 15,
                                color: Mono.onDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 14,
                                  color: Mono.onDarkMuted,
                                ),
                                SizedBox(width: 4),
                                Row(
                                  children: [
                                    Text(
                                      "12:00 PM",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Mono.onDarkMuted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: VerticalDivider(
                                        color: Mono.onDarkMuted,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      "Economy - Y",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Mono.onDarkMuted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Text("MJI", style: Mono.caption),
                          Text(
                            "12:00",
                            style: TextStyle(
                              fontSize: 22,
                              color: Mono.ink,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("MJI", style: Mono.caption),
                          Text(
                            "12:00",
                            style: TextStyle(
                              fontSize: 22,
                              color: Mono.ink,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Footer section
          Section(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1350 USD",
                  style: TextStyle(
                    fontSize: 18,
                    color: Mono.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text(
                    "Book Flight",
                    style: TextStyle(
                      fontSize: 16,
                      color: Mono.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
