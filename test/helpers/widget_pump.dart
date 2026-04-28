import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [widget] inside a minimal [MaterialApp] for widget tests.
Future<void> pumpTicket(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(child: widget),
      ),
    ),
  );
  await tester.pump();
}
