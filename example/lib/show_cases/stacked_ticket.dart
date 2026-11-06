import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

/// Example page demonstrating the stacked layers functionality in Ticketcher.
class StackedTicket extends StatelessWidget {
  const StackedTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stacked Effect')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Ticketcher(
          decoration: TicketcherDecoration(
            borderRadius: TicketRadius(radius: 20, corner: TicketCorner.all),
            backgroundColor: Mono.white,
            border: Border.all(color: Mono.black, width: 2),
            shadow: BoxShadow(
              color: Mono.black.withValues(alpha: 0.12),
              blurRadius: 3,
              offset: Offset(0, 10),
            ),
            divider: TicketDivider.dashed(
              color: Mono.line,
              thickness: 1,
              dashWidth: 8,
              dashSpace: 6,
              padding: 10,
            ),
            stackEffect: StackEffect(
              count: 2,
              offset: 10,
              widthStep: 15,
              color: Mono.blue,
            ),
          ),
          sections: [
            // Header section
            Section(
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
                          Icon(Icons.airplanemode_active, color: Mono.onDark),
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
                                    color: Mono.blueLight,
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
            Section(
              padding: EdgeInsets.all(4),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Mono.blueNight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.airplanemode_active, color: Mono.onDark),
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
                                    color: Mono.blueLight,
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
                        color: Mono.onDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
