import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class StitchingShowcase extends StatelessWidget {
  const StitchingShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stitching Border')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Vertical coupon — white thread on volt blue, the reference look.
            VTicketcher(
              width: 300,
              decoration: const TicketcherDecoration(
                backgroundColor: Mono.blue,
                borderRadius: TicketRadius(radius: 24),
                stitch: TicketStitch(
                  color: Mono.white,
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
                          color: Mono.onDark,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
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
                        style: TextStyle(color: Mono.blueSoft, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Horizontal — blue thread on black, larger inset.
            Ticketcher.horizontal(
              height: 150,
              decoration: const TicketcherDecoration(
                backgroundColor: Mono.black,
                borderRadius: TicketRadius(radius: 18),
                stitch: TicketStitch(
                  color: Mono.blueLight,
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
                        color: Mono.blueLight,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
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
                        color: Mono.onDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
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
                backgroundColor: Mono.white,
                borderRadius: const TicketRadius(radius: 16),
                border: Border.all(color: Mono.black, width: 2),
                stitch: const TicketStitch(
                  color: Mono.ash,
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
                    child: Center(
                      child: Text(
                        'Border + stitch',
                        style: TextStyle(
                          color: Mono.ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                Section(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        'two independent layers',
                        style: Mono.caption,
                      ),
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
