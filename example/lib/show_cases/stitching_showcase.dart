import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

class StitchingShowcase extends StatelessWidget {
  const StitchingShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF19A8B8);
    return Scaffold(
      appBar: AppBar(title: const Text('Stitching Border')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Vertical coupon — white thread on teal, the reference look.
            VTicketcher(
              width: 300,
              decoration: const TicketcherDecoration(
                backgroundColor: teal,
                borderRadius: TicketRadius(radius: 24),
                stitch: TicketStitch(
                  color: Colors.white,
                  inset: 12,
                  length: 7,
                  spacing: 7,
                  thickness: 2,
                ),
              ),
              sections: const [
                Section(
                  padding: EdgeInsets.all(24),
                  child: SizedBox(
                    height: 90,
                    child: Center(
                      child: Text(
                        'ADMIT ONE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Section(
                  padding: EdgeInsets.all(24),
                  child: SizedBox(
                    height: 70,
                    child: Center(
                      child: Text(
                        'No. 042 · Row C',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Horizontal — gold thread, larger inset.
            Ticketcher.horizontal(
              height: 150,
              decoration: const TicketcherDecoration(
                backgroundColor: Color(0xFF2B2B3A),
                borderRadius: TicketRadius(radius: 18),
                stitch: TicketStitch(
                  color: Color(0xFFF4C95D),
                  inset: 10,
                  length: 6,
                  spacing: 5,
                  thickness: 2,
                ),
              ),
              sections: const [
                Section(
                  widthFactor: 1,
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      '50%\nOFF',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF4C95D),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Section(
                  widthFactor: 2,
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'CODE: STITCH50',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stitch + solid border together (independent layers).
            VTicketcher(
              width: 300,
              decoration: TicketcherDecoration(
                backgroundColor: Colors.white,
                borderRadius: const TicketRadius(radius: 16),
                border: Border.all(color: Colors.indigo.shade300, width: 2),
                stitch: TicketStitch(
                  color: Colors.indigo.shade300,
                  inset: 9,
                  length: 5,
                  spacing: 5,
                  thickness: 1.5,
                ),
              ),
              sections: const [
                Section(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 70,
                    child: Center(child: Text('Border + stitch')),
                  ),
                ),
                Section(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 60,
                    child: Center(child: Text('two independent layers')),
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
