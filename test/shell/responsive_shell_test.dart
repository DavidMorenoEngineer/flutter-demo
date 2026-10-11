import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/app.dart';
import 'package:flutter_demo/core/di/injection.dart';
import 'package:flutter_demo/core/theme/sx_theme.dart';
import 'package:flutter_demo/features/shell/presentation/app_destination.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/bottom_nav.dart';
import 'package:flutter_demo/features/shell/presentation/widgets/top_nav.dart';

Future<void> pumpApp(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size * 2;
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await getIt.reset();
  configureDependencies();
  await tester.pumpWidget(const SideKixDemoApp());
  await tester.pump(const Duration(milliseconds: 100));
}

/// Pumps in 100 ms frames so animations and streamed tokens actually advance.
Future<void> settle(WidgetTester tester, Duration total) async {
  for (var t = Duration.zero; t < total; t += const Duration(milliseconds: 100)) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUpAll(() => SxFonts.enabled = false);
  tearDown(() => getIt.reset());

  testWidgets('phone: bottom bar carries the same seven items as the website top nav', (tester) async {
    await pumpApp(tester, const Size(390, 844));
    expect(find.byType(SxBottomNav), findsOneWidget);
    expect(find.byType(SxTopNav), findsNothing);
    for (final d in AppDestination.values) {
      expect(find.descendant(of: find.byType(SxBottomNav), matching: find.text(d.label)), findsOneWidget);
    }
    expect(find.text('Talk to Kix'), findsWidgets);
  });

  testWidgets('desktop: the same destinations move to a website-style top nav', (tester) async {
    await pumpApp(tester, const Size(1280, 800));
    expect(find.byType(SxTopNav), findsOneWidget);
    expect(find.byType(SxBottomNav), findsNothing);
    for (final d in AppDestination.values) {
      expect(find.descendant(of: find.byType(SxTopNav), matching: find.text(d.label)), findsOneWidget);
    }
  });

  for (final size in const [Size(360, 740), Size(768, 1024), Size(1440, 900)]) {
    testWidgets('every screen lays out without overflow at ${size.width.toInt()}x${size.height.toInt()}', (tester) async {
      await pumpApp(tester, size);
      for (final d in AppDestination.values) {
        final nav = size.width >= 900 ? find.byType(SxTopNav) : find.byType(SxBottomNav);
        await tester.tap(find.descendant(of: nav, matching: find.text(d.label)));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull, reason: '${d.label} overflowed at $size');
      }
    });
  }

  testWidgets('Kix: tell it an idea, answer its question, and a Journey Map appears', (tester) async {
    await pumpApp(tester, const Size(390, 844));
    await tester.tap(find.text('Talk to Kix').first);
    await settle(tester, const Duration(milliseconds: 600));
    expect(find.textContaining("I'm Kix"), findsOneWidget);

    await tester.tap(find.text('I want to open a bakery'));
    await settle(tester, const Duration(seconds: 6));
    expect(find.textContaining('biggest thing standing between you and starting'), findsOneWidget);

    await tester.tap(find.text('Not enough time'));
    await settle(tester, const Duration(seconds: 12));
    expect(find.text('YOUR JOURNEY MAP'), findsOneWidget);
    expect(find.text('Get clear'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
