import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_simple_demo/main.dart';

void main() {
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding
        .ensureInitialized(); //if the integration test driver is initialized, reinitializing it if required
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy
        .fullyLive; //Setting framePolicy to fullyLive is good for testing animated code.

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final listFinder = find.byType(ListView);

      // The traceAction() function records the actions and generates a timeline summary.
      await binding.traceAction(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });
  });
}
