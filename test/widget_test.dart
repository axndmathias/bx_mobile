import 'package:bx_mobile/app_dependencies.dart';
import 'package:bx_mobile/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BXMobile startet und zeigt den Login-Bildschirm an', (
    WidgetTester tester,
  ) async {
    // Initialisiert die Abhängigkeiten für den Test
    final dependencies = AppDependencies();
    await dependencies.init();

    // App mit den initialisierten Abhängigkeiten bauen
    await tester.pumpWidget(BxMobileApp(appDependencies: dependencies));

    // Warten, bis der initiale Async-Check (checkStoredSession) abgeschlossen ist
    await tester.pumpAndSettle();

    // Überprüft, ob die exakten Texte des Login-Bildschirms angezeigt werden
    expect(find.text('Bexio ERP Suite'), findsOneWidget);
    expect(find.text('Demo-Modus starten (Bexio Sandbox)'), findsOneWidget);
  });
}
