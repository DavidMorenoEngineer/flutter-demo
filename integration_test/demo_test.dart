import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/app.dart';
import 'package:flutter_demo/core/di/injection.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/bottom_nav.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/top_nav.dart';
import 'package:integration_test/integration_test.dart';

/// Scripted walkthrough used to record the demo video — no human input:
/// every tab, a flipped advisor card, then a full conversation with Kix.
/// Runs on the real clock so animations and streamed tokens play at true speed.
Future<void> _wait(WidgetTester t, double seconds) async {
  for (var i = 0; i < (seconds * 10).round(); i++) {
    await t.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await t.pump();
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('demo walkthrough', (tester) async {
    configureDependencies();
    await tester.pumpWidget(const SideKixDemoApp());
    await _wait(tester, 4); // Home

    Future<void> goTo(String label, {double hold = 3}) async {
      final nav = find.byType(SxBottomNav).evaluate().isNotEmpty ? find.byType(SxBottomNav) : find.byType(SxTopNav);
      await tester.tap(find.descendant(of: nav, matching: find.text(label)));
      await tester.pump();
      await _wait(tester, hold);
    }

    await goTo('How it works');
    await goTo('Membership', hold: 1.5);
    await tester.tap(find.text('Yearly'));
    await tester.pump();
    await _wait(tester, 2.5);
    await goTo('Advisors', hold: 1.5);
    await tester.tap(find.text('Maya Okafor'));
    await tester.pump();
    await _wait(tester, 3);
    await goTo('Partners');
    await goTo('Events', hold: 1.5);
    await tester.tap(find.textContaining('North Carolina ·'));
    await tester.pump();
    await _wait(tester, 2.5);
    await goTo('Resources', hold: 1.5);
    await tester.tap(find.text('Funding'));
    await tester.pump();
    await _wait(tester, 2.5);

    // ---- Kix, the centrepiece
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await _wait(tester, 2.5);
    await tester.enterText(find.byType(TextField), 'I want to open a neighbourhood bakery');
    await tester.pump();
    await _wait(tester, 1.5);
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();
    await _wait(tester, 7); // Kix listens first and asks one question
    await tester.tap(find.text('Not enough time'));
    await tester.pump();
    await _wait(tester, 11); // ...then draws the Journey Map
    await tester.tap(find.textContaining('20-minute'));
    await tester.pump();
    await _wait(tester, 1.5);
    await tester.tap(find.text('Name who it is for'));
    await tester.pump();
    await _wait(tester, 2.5);
    await tester.tap(find.text('Find me an advisor'));
    await tester.pump();
    await _wait(tester, 6);
  });
}
