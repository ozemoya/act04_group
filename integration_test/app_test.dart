import 'package:act04_group/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture a real changed-state screen on Android', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    for (var i = 0; i < 6; i++) {
      await tester.ensureVisible(find.text('SHARE'));
      await tester.tap(find.text('SHARE'));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(find.text('SAVE'));
    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();
    expect(find.text('TRENDING NOW'), findsOneWidget);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, 1200),
    );
    await tester.pumpAndSettle();
    await binding.takeScreenshot('CS-Coders-Round3-ChangedState');
  });
}
