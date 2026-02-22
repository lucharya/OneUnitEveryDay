import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:one_unit_every_day/main.dart';

void main() {
  testWidgets('App should start', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: OneUnitEveryDayApp()),
    );
    // Basic smoke test - app should start without crashing
    expect(find.text('OneUnitEveryDay'), findsOneWidget);
  });
}
