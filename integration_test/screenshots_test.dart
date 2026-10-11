import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/app.dart';
import 'package:flutter_demo/core/di/injection.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/bottom_nav.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/top_nav.dart';
import 'package:integration_test/integration_test.dart';

/// Walks every screen and its interactive states, holding each one still and
/// printing `SHOT <name> <epoch-ms>` so a recorder script can cut a frame at
/// exactly that moment (see tool/capture_screenshots.sh).
Future<void> _wait(WidgetTester t, double seconds) async {
  for (var i = 0; i < (seconds * 10).round(); i++) {
    await t.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await t.pump();
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('screenshot walkthrough', (tester) async {
    configureDependencies();
    await tester.pumpWidget(const SideKixDemoApp());
    // ignore: avoid_print
    print('SHOT start ${DateTime.now().millisecondsSinceEpoch}');

    /// Holds the current state still, then logs the moment to cut.
    Future<void> shot(String name, {double settle = 2.5}) async {
      await _wait(tester, settle);
      // ignore: avoid_print
      print('SHOT $name ${DateTime.now().millisecondsSinceEpoch}');
      await _wait(tester, 1.6); // time for the host to screenshot
    }

    Future<void> tap(Finder f, {double after = 0}) async {
      await tester.tap(f);
      await tester.pump();
      if (after > 0) await _wait(tester, after);
    }

    Future<void> goTo(String label) {
      final nav = find.byType(SxBottomNav).evaluate().isNotEmpty ? find.byType(SxBottomNav) : find.byType(SxTopNav);
      return tap(find.descendant(of: nav, matching: find.text(label)));
    }

    Future<void> scroll(String visibleText, double dy) async {
      await tester.drag(find.text(visibleText).first, Offset(0, -dy));
      await tester.pump();
    }

    await shot('home', settle: 3);
    await scroll('Build it now.', 620);
    await shot('home-gap');

    await goTo('How it works');
    await shot('how-it-works');

    await goTo('Membership');
    await shot('membership');
    await tap(find.text('Yearly'));
    await shot('membership-yearly');
    await scroll('Start where you are, pay for what you need.', 700);
    await shot('membership-roadmap');

    await goTo('Advisors');
    await shot('advisors');
    await tap(find.text('Maya Okafor'), after: 0.2);
    await shot('advisors-flipped', settle: 1.5);

    await goTo('Partners');
    await shot('partners');
    await scroll('Collaboration is what builds community.', 650);
    await shot('partners-network');

    await goTo('Events');
    await shot('events');
    await tap(find.textContaining('North Carolina ·'));
    await shot('events-filtered', settle: 1.5);

    await goTo('Resources');
    await shot('resources');
    await tap(find.text('Funding'));
    await shot('resources-filtered', settle: 1.5);

    // ---- Kix
    await tap(find.byType(FloatingActionButton));
    await shot('kix-welcome', settle: 2.5);
    await tester.enterText(find.byType(TextField), 'I want to open a neighbourhood bakery');
    await tester.pump();
    await shot('kix-typing', settle: 1);
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();
    await shot('kix-question', settle: 7);
    await tap(find.text('Not enough time'));
    await shot('kix-journey-map', settle: 11);
    await tap(find.textContaining('20-minute'));
    await _wait(tester, 0.5);
    await tap(find.text('Name who it is for'));
    await shot('kix-steps-ticked', settle: 1.5);
    await tap(find.text('Find me an advisor'));
    await shot('kix-advisor', settle: 6);
    // ignore: avoid_print
    print('SHOT end ${DateTime.now().millisecondsSinceEpoch}');
  });
}
