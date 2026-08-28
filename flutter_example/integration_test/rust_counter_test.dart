import 'package:flutter_example/main.dart';
import 'package:flutter_example/src/rust/frb_generated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(RustLib.init);

  testWidgets('Rust counter increments through native assets', (tester) async {
    await tester.pumpWidget(const UnifiedApp());
    await tester.tap(find.text('Rust counter'));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byTooltip('Increment Rust counter'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
