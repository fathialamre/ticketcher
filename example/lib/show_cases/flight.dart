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
      padding: const EdgeInsets.only(bottom: 10),
      child: Ticketcher(
        decoration: TicketcherDecoration(
          borderRadius: TicketRadius(radius: 20, corner: TicketCorner.all),
          backgroundColor: Colors.white,
          border: Border.all(color: Colors.grey.shade100, width: 2),
          divider: TicketDivider.dashed(
            color: Colors.grey.shade300,
            thickness: 1,
            dashWidth: 8,
            dashSpace: 0.01,
          ),
        ),
        primarySection: Section(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey.shade50,
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
                          Text("Libyan Airways"),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 4),
                              Row(
                                children: [
                                  Text(
                                    "12:00 PM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                    child: VerticalDivider(
                                      color: Colors.grey.shade400,
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(
                                    "Economy - Y",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                    Column(
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
                  ],
                ),
              ),
            ],
          ),
        ),
        secondarySection: Section(
          padding: EdgeInsets.all(10),
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
      ),
    );
  }
}
