// This is a basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// --- PERBAIKAN ADA DI SINI ---
// Kita ubah path import agar menunjuk ke file main.dart di dalam folder UAS,
// tempat kelas 'MyApp' didefinisikan.
import 'package:pemrogramanmobile1/UAS/main.dart';
// ----------------------------

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Baris ini sekarang akan menemukan 'MyApp' dengan benar.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
