import 'package:flutter/material.dart';

import 'app_dependencies.dart';
import 'features/auth/presentation/views/auth_wrapper.dart';

void main() async {
  // Sicherstellen, dass die Flutter-Bindungen initialisiert sind
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisieren der manuellen Dependency Injection (AppDependencies)
  final appDependencies = AppDependencies();
  await appDependencies.init();

  runApp(BxMobileApp(appDependencies: appDependencies));
}

class BxMobileApp extends StatelessWidget {
  final AppDependencies appDependencies;

  const BxMobileApp({super.key, required this.appDependencies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BXMobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Der Startbildschirm verwendet den AuthWrapper, gesteuert durch den AuthNotifier
      home: FutureBuilder(
        // Führt die Sitzungsprüfung beim App-Start einmalig aus
        future: appDependencies.authNotifier.checkStoredSession(),
        builder: (context, snapshot) {
          // Zeigt während der ersten Prüfung einen Ladebildschirm
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Übergibt den initialisierten AuthNotifier an den Wrapper
          return AuthWrapper(authNotifier: appDependencies.authNotifier);
        },
      ),
    );
  }
}
