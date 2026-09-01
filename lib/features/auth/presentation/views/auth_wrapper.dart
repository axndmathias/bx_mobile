import 'package:bx_mobile/features/auth/presentation/provider/auth_notifier.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

/// **AuthWrapper**
/// Überwacht den Authentifizierungsstatus und steuert die Navigation
/// reaktiv zwischen dem Login-Bildschirm und dem Hauptbereich (Dashboard).
class AuthWrapper extends StatelessWidget {
  /// Instanz des AuthNotifiers zur Zustandsüberwachung
  final AuthNotifier authNotifier;

  const AuthWrapper({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: authNotifier,
      builder: (context, child) {
        // Fallunterscheidung basierend auf dem aktuellen Authentifizierungsstatus
        switch (authNotifier.status) {
          case AuthStatus.initial:
          case AuthStatus.unauthenticated:
          case AuthStatus.error:
            // Zeigt den Login-Bildschirm, wenn der Benutzer nicht angemeldet ist
            return LoginView(authNotifier: authNotifier);

          case AuthStatus.loading:
            // Zeigt während Initialisierungen oder Ladevorgängen einen Ladebildschirm
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case AuthStatus.authenticated:
            // Ruft die Daten des aktuell angemeldeten Benutzers ab
            final user = authNotifier.user;

            // Hauptbereich / Dashboard mit Demo-Benutzerinformationen
            return Scaffold(
              appBar: AppBar(
                title: const Text('BXMobile — Dashboard'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => authNotifier.logout(),
                    tooltip: 'Abmelden',
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Erfolgreich angemeldet (Bexio Sandbox)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Karte zur Darstellung der Sandbox-Benutzerdetails
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Name'),
                              subtitle: Text(user?.name ?? 'Demo Benutzer'),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text('E-Mail'),
                              subtitle: Text(
                                user?.email ?? 'sandbox@bxmobile.ch',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
