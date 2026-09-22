import 'package:act04_group/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('engagement actions update the score and trending status', (
    tester,
  ) async {
    await tester.pumpWidget(const ViralContentStudioApp());
    expect(find.text('0 / 20'), findsOneWidget);
    for (var i = 0; i < 6; i++) {
      await tester.ensureVisible(find.text('SHARE'));
      await tester.tap(find.text('SHARE'));
      await tester.pumpAndSettle();
    }
    expect(find.text('18 / 20'), findsOneWidget);
    await tester.ensureVisible(find.text('SAVE'));
    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();
    expect(find.text('TRENDING NOW'), findsOneWidget);
  });

  testWidgets('theme toggle changes the app theme', (tester) async {
    await tester.pumpWidget(const ViralContentStudioApp());
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
  });
}
