import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class FlipShowcase extends StatefulWidget {
  const FlipShowcase({super.key});

  @override
  State<FlipShowcase> createState() => _FlipShowcaseState();
}

class _FlipShowcaseState extends State<FlipShowcase> {
  final _controller = FlipTicketcherController();
  bool _isFront = true;

  Widget _front() => VTicketcher(
    width: 280,
    decoration: TicketcherDecoration(
      backgroundColor: Mono.black,
      borderRadius: const TicketRadius(radius: 18),
      divider: TicketDivider.dashed(color: Mono.graphite),
    ),
    sections: const [
      Section(
        padding: EdgeInsets.all(24),
        child: SizedBox(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MUSEUM PASS',
                style: TextStyle(
                  color: Mono.blueLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'National Museum',
                style: TextStyle(
                  color: Mono.onDark,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              Spacer(),
              Text(
                'SAT 21 NOV · 10:00',
                style: TextStyle(color: Mono.onDarkMuted),
              ),
            ],
          ),
        ),
      ),
      Section(
        padding: EdgeInsets.all(24),
        child: SizedBox(
          height: 70,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '2 ADULTS',
              style: TextStyle(
                color: Mono.onDark,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _back() => VTicketcher(
    width: 280,
    decoration: TicketcherDecoration(
      backgroundColor: Mono.white,
      borderRadius: const TicketRadius(radius: 18),
      divider: TicketDivider.dashed(color: Mono.line),
    ),
    sections: const [
      Section(
        padding: EdgeInsets.all(24),
        child: SizedBox(
          height: 180,
          child: Center(
            child: Icon(Icons.qr_code_2, size: 150, color: Mono.ink),
          ),
        ),
      ),
      Section(
        padding: EdgeInsets.all(24),
        child: SizedBox(
          height: 70,
          child: Text(
            'Valid for one day. Non-refundable. '
            'Show this code at the gate.',
            style: Mono.caption,
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flip Ticket')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Tap or swipe sideways to flip', style: Mono.caption),
          const SizedBox(height: 16),
          Center(
            child: FlipTicketcher(
              controller: _controller,
              trigger: FlipTrigger.tapOrSwipe,
              front: _front(),
              back: _back(),
              onFlip: (isFront) => setState(() => _isFront = isFront),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: FilledButton.icon(
              onPressed: _controller.flip,
              icon: const Icon(Icons.flip),
              label: Text(_isFront ? 'Show back' : 'Show front'),
            ),
          ),
          const SizedBox(height: 40),
          const Text('Vertical axis', style: Mono.caption),
          const SizedBox(height: 16),
          Center(
            child: FlipTicketcher(
              axis: Axis.vertical,
              trigger: FlipTrigger.tapOrSwipe,
              front: _front(),
              back: _back(),
            ),
          ),
        ],
      ),
    );
  }
}
