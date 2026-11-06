import 'package:flutter/material.dart';
import 'package:ticketcher/ticketcher.dart';

import '../theme/gallery_mono.dart';

class StampShowcase extends StatelessWidget {
  const StampShowcase({super.key});

  static List<Section> _sections(
    String title,
    String detail, {
    Color tint = Mono.ash,
    String footer = 'No. 042 · Row C · Seat 7',
  }) => [
    Section(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(detail, style: Mono.eyebrow.copyWith(color: tint)),
            const SizedBox(height: 8),
            Text(title, style: Mono.title),
          ],
        ),
      ),
    ),
    Section(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 50,
        child: Center(child: Text(footer, style: Mono.body)),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const blue = Mono.blue;
    final shapes = <TicketStamp>[
      const TicketStamp(text: 'RECT', shape: StampShape.rectangle, color: blue),
      const TicketStamp(
        text: 'ROUNDED',
        shape: StampShape.roundedRectangle,
        color: blue,
      ),
      const TicketStamp(text: 'CIRCLE', shape: StampShape.circle, color: blue),
      const TicketStamp(text: 'OVAL', shape: StampShape.oval, color: blue),
      const TicketStamp(
        text: 'SEAL',
        shape: StampShape.seal,
        borderStyle: StampBorderStyle.single,
        color: blue,
      ),
      const TicketStamp(
        text: 'HEXAGON',
        shape: StampShape.hexagon,
        color: blue,
      ),
      const TicketStamp(text: 'RIBBON', shape: StampShape.ribbon, color: blue),
      const TicketStamp(
        text: 'DASHED',
        borderStyle: StampBorderStyle.dashed,
        color: blue,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Status Stamps')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          VTicketcher(
            width: 320,
            decoration: const TicketcherDecoration(
              backgroundColor: Mono.white,
              stamp: TicketStamp.used(
                subtitle: '14 DEC 2026',
                color: Mono.blue,
                animateIn: true,
              ),
            ),
            sections: _sections('BEN → TIP', 'TRAIN · 2ND CLASS'),
          ),
          const SizedBox(height: 24),
          Directionality(
            textDirection: TextDirection.rtl,
            child: VTicketcher(
              width: 320,
              decoration: const TicketcherDecoration(
                backgroundColor: Mono.white,
                stamp: TicketStamp(
                  text: 'مُستخدَمة',
                  subtitle: '١٤ ديسمبر',
                  shape: StampShape.seal,
                  borderStyle: StampBorderStyle.single,
                  color: Mono.blue,
                  rotation: -12,
                  // Sits on the empty end side, clear of the title.
                  alignment: Alignment(-0.82, -0.3),
                  textStyle: TextStyle(fontSize: 16),
                  subtitleStyle: TextStyle(fontSize: 10),
                ),
              ),
              sections: _sections(
                'معرض الكتاب',
                'الدخول العام',
                tint: Mono.blue,
                footer: 'رقم ٠٤٢ · البوابة ٣',
              ),
            ),
          ),
          const SizedBox(height: 24),
          VTicketcher(
            width: 320,
            decoration: const TicketcherDecoration(
              backgroundColor: Mono.white,
              status: TicketStatus.expired,
              stamp: TicketStamp.voided(text: 'EXPIRED', color: Mono.black),
            ),
            sections: _sections('OPEN AIR', 'FESTIVAL · DAY 2'),
          ),
          const SizedBox(height: 24),
          Ticketcher.horizontal(
            height: 150,
            decoration: const TicketcherDecoration(
              backgroundColor: Mono.white,
              stamp: TicketStamp.paid(
                color: Mono.blue,
                alignment: Alignment(-0.3, 0),
              ),
            ),
            sections: const [
              Section(
                widthFactor: 2,
                padding: EdgeInsets.all(16),
                child: Center(child: Text('Invoice #8821', style: Mono.body)),
              ),
              Section(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    '\$120',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Mono.ink,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Shapes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Mono.ink,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final stamp in shapes)
                TicketStampMark(stamp: stamp.copyWith(rotation: 0)),
              const TicketStampMark(stamp: TicketStamp.vip(color: Mono.black)),
            ],
          ),
        ],
      ),
    );
  }
}
