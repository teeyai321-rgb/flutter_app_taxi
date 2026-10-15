import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_taxi/main.dart';

void main() {
  testWidgets('app loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TaxiFareProject());

    expect(find.text('Body Health Calculate'), findsOneWidget);
  });
}
