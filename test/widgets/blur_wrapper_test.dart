import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketcher/ticketcher.dart';
import 'package:ticketcher/src/widgets/blur_wrapper.dart';

void main() {
  testWidgets('null blurEffect ⇒ no BackdropFilter, no ImageFiltered',
      (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: BlurWrapper(child: SizedBox(width: 100, height: 100)),
      ),
    );

    expect(find.byType(BackdropFilter), findsNothing);
    expect(find.byType(ImageFiltered), findsNothing);
  });

  testWidgets('sigma == 0 ⇒ no BackdropFilter (fast-path)', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlurWrapper(
          blurEffect: BlurEffect.backdrop(sigma: 0),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    expect(find.byType(BackdropFilter), findsNothing);
    expect(find.byType(ImageFiltered), findsNothing);
  });

  testWidgets('sigma > 0 backdrop ⇒ BackdropFilter present', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlurWrapper(
          blurEffect: BlurEffect.backdrop(sigma: 5),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    expect(find.byType(BackdropFilter), findsOneWidget);
  });

  testWidgets('sigma == 0 gaussian ⇒ no ImageFiltered (fast-path)',
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlurWrapper(
          blurEffect: BlurEffect.gaussian(sigma: 0),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    expect(find.byType(ImageFiltered), findsNothing);
  });
}
