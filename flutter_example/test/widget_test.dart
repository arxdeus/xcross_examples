import 'package:flutter/material.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_example/src/rust_counter_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('merged shell opens Dart counter and increments', (tester) async {
    await tester.pumpWidget(
      UnifiedApp(rustCounterFactory: () async => _FakeRustCounter()),
    );

    expect(find.text('xcross Flutter Examples'), findsOneWidget);
    expect(find.text('Rust counter'), findsOneWidget);
    expect(find.text('Firebase actions'), findsOneWidget);
    expect(find.text('Fonts and icons'), findsOneWidget);
    expect(find.text('Dart counter'), findsOneWidget);

    await tester.tap(find.text('Dart counter'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('dart-counter-value')), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byTooltip('Increment Dart counter'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Rust counter accepts an injected implementation', (
    tester,
  ) async {
    await tester.pumpWidget(
      UnifiedApp(rustCounterFactory: () async => _FakeRustCounter()),
    );

    await tester.tap(find.text('Rust counter'));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byTooltip('Increment Rust counter'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}

class _FakeRustCounter implements RustCounter {
  int _value = 0;

  @override
  int get value => _value;

  @override
  void increment() => _value++;
}
