import 'package:bx_mobile/features/auth/presentation/provider/auth_notifier.dart';
import 'package:flutter/material.dart';

// Importieren Sie hier den AuthNotifier, falls noch nicht geschehen:
// import '../viewmodels/auth_notifier.dart';

class LoginView extends StatelessWidget {
  /// Instanz des AuthNotifiers zur Verwaltung des Anmeldezustands
  final AuthNotifier authNotifier;

  const LoginView({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BXMobile — Anmeldung')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListenableBuilder(
          listenable: authNotifier,
          builder: (context, child) {
            // Zeigt einen Ladeindikator während des Authentifizierungsprozesses an
            if (authNotifier.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Bexio ERP Suite',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Shell Container App',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 48),
                // Schaltfläche zum Starten des Demo-Modus über die Bexio Sandbox
                ElevatedButton.icon(
                  onPressed: () async {
                    await authNotifier.loginDemo();
                    print(authNotifier.errorMessage.toString());
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Demo-Modus starten (Bexio Sandbox)'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                // Fehleranzeige, falls bei der Anmeldung ein Problem auftritt
                if (authNotifier.errorMessage != null) ...[
                  const SizedBox(height: 24),
                  Text(
                    authNotifier.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
