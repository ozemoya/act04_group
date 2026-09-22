import 'dart:async';

import 'package:act04_group/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('demonstrate theme, engagement actions and trending state', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    Future<void> pause() async {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(seconds: 2)),
      );
      await tester.pumpAndSettle();
    }

    await pause();
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    await pause();
    for (var i = 0; i < 6; i++) {
      await tester.ensureVisible(find.text('SHARE'));
      await tester.tap(find.text('SHARE'));
      await tester.pumpAndSettle();
      await pause();
    }
    await tester.ensureVisible(find.text('SAVE'));
    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, 1200),
    );
    await tester.pumpAndSettle();
    expect(find.text('TRENDING NOW'), findsOneWidget);
    await pause();
  });
}
