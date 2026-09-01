import 'package:bx_mobile/app_dependencies.dart';
import 'package:bx_mobile/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BXMobile startet und zeigt den Login-Bildschirm an', (
    WidgetTester tester,
  ) async {
    // Initialisiert die Abhängigkeiten für den Test
    final dependencies = AppDependencies();

    // Für Tests mocken/initialisieren wir hier minimal oder rufen init auf,
    // falls das Test-Setup eine echte lokale Datei/Storage erlaubt.
    // Hinweis: Für reine Widget-Tests ohne echtes SecureStorage kann man mocken,
    // aber schauen wir, wie sich das AppDependencies-Objekt verhält:
    await dependencies.init();

    // App mit dem initialisierten AuthNotifier bauen
    await tester.pumpWidget(
      BxMobileApp(authNotifier: dependencies.authNotifier),
    );

    // Überprüft, ob der Titel des Login-Bildschirms angezeigt wird
    expect(find.text('Bexio ERP Mobile Suite'), findsOneWidget);
    expect(find.text('Demo-Modus starten'), findsOneWidget);
  });
}
