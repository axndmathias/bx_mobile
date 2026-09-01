import 'package:bx_mobile/features/auth/presentation/provider/auth_notifier.dart';
import 'package:flutter/material.dart';

import 'app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialisiert den reinen Abhängigkeitscontainer (Dependencies)
  final dependencies = AppDependencies();
  await dependencies.init();

  runApp(BxMobileApp(authNotifier: dependencies.authNotifier));
}

class BxMobileApp extends StatelessWidget {
  final AuthNotifier authNotifier;

  const BxMobileApp({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BXMobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: AuthWrapper(authNotifier: authNotifier),
    );
  }
}

/// **AuthWrapper**
/// Überprüft den anfänglichen Sitzungsstatus, sobald die App geöffnet wird.
class AuthWrapper extends StatefulWidget {
  final AuthNotifier authNotifier;

  const AuthWrapper({super.key, required this.authNotifier});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Löst die Überprüfung der lokalen verschlüsselten Sitzung beim Start aus
    widget.authNotifier.checkStoredSession();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.authNotifier,
      builder: (context, child) {
        final notifier = widget.authNotifier;

        if (notifier.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (notifier.isAuthenticated) {
          return Scaffold(
            appBar: AppBar(title: const Text('BXMobile - Dashboard')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Willkommen, ${notifier.user?.name ?? ""}!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => notifier.logout(),
                    child: const Text('Abmelden (Logout)'),
                  ),
                ],
              ),
            ),
          );
        }

        // Einfacher Login- / Demo-Bildschirm
        return Scaffold(
          appBar: AppBar(title: const Text('BXMobile - Login')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bexio ERP Mobile Suite',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => notifier.loginDemo(),
                    icon: const Icon(Icons.login),
                    label: const Text('Demo-Modus starten'),
                  ),
                  if (notifier.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      notifier.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
