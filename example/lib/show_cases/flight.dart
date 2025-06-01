import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

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
        decoration: TicketcherDecoration(
          borderRadius: TicketRadius(radius: 20, corner: TicketCorner.top),
          backgroundColor: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          shadow: BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 3,
            offset: Offset(0, 10),
          ),
          divider: TicketDivider.dashed(
            color: Theme.of(context).colorScheme.inversePrimary,
            thickness: 1,
            dashWidth: 8,
            dashSpace: 6,
            padding: 10,
          ),
          bottomBorderStyle: BorderPattern(height: 10, shape: BorderShape.wave),
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
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.airplanemode_active),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Libyan Airways",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 4),
                                Row(
                                  children: [
                                    Text(
                                      "12:00 PM",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: VerticalDivider(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      "Economy - Y",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
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
                          Text("MJI"),
                          Text(
                            "12:00",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("MJI"),
                          Text(
                            "12:00",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
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
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text(
                    "Book Flight",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
