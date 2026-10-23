import 'package:flutter_test/flutter_test.dart';

import 'package:ma_biblio/main.dart';

void main() {
  testWidgets('La page d\'accueil affiche MaBiblio', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MaBiblio'), findsOneWidget);
  });
}
