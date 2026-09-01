# Projekt-Backlog — Modul Benutzer & Authentifizierung

**Projekt:** BXMobile
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.1 (Aktualisiert)

---

## Schritt 01: Requirements & Features

- [x] **TASK-01:** Definition von PRD, MVP sowie Spezifikation des Demo-Modus (Bexio Sandbox) und des Produktions-Modus [QR-Code](cite: 2).

## Schritt 02: UI & Screen Planning

- [x] **TASK-02:** User Flow für den Demo-Benutzer definieren [Home -> Als Demo anmelden -> Bexio Sandbox -> Dashboard](cite: 2).

## Schritt 03: Architecture & Folder Structure

- [x] **TASK-03:** Anlegen der Clean Architecture Feature-First Ordnerstruktur (`app/`, `core/`, `features/auth/`, `features/bmx_modules/`, `shared/`)[cite: 2].

## Schritt 04: Project Setup & Git

- [x] **TASK-04:** Konfiguration der `pubspec.yaml` mit den erforderlichen Abhängigkeiten (`encrypt`, `path_provider`, `http`/`dio`, `provider`, etc.)[cite: 2].
- [x] **TASK-05:** Implementierung des reinen Injektionscontainers `AppDependencies` (`lib/app_dependencies.dart`) und Verzicht auf GetIt/Bloc zugunsten von `ChangeNotifier`.

## Schritt 05: Data Models

- [x] **TASK-06:** Implementierung von `BxmLicenseModel` und `UserModel` mit Unterstützung für das Demo-Flag (`isDemo: true`)[cite: 2].

## Schritt 06: Services & API Integration (Bexio Demo)

- [x] **TASK-07:** Erstellung des `SecureJsonStorageService` für die lokale AES-256-Verschlüsselung (`core/storage/`)[cite: 2].
- [x] **TASK-08:** Konfiguration des `AuthLocalDataSource`, `AuthRepositoryImpl` und der Use Cases für die lokale und Demo-Authentifizierung.

## Schritt 07: State Management

- [x] **TASK-09:** Erstellung des `AuthNotifier` zur Verwaltung des Demo-Login-Status und des Sitzungszustands über das native `ChangeNotifier`-Muster.

## Schritt 08: UI & Screen Development (Fokus Demo)

- [x] **TASK-10:** Erstellung des Willkommens-Bildschirms / AuthWrappers mit hervorgehobener Schaltfläche "Demo-Modus starten (Bexio)"[cite: 2].
- [ ] **TASK-11:** Erstellung des Haupt-Dashboards mit visuellem Hinweis "Demo-Modus aktiv" und dynamischer Modul-Navigation[cite: 2].
- [ ] **TASK-12:** (Phase 2) Entwicklung des QR-Code-Scanners und des traditionellen Logins[cite: 2].

## Schritt 09: Testing & Debugging

- [x] **TASK-13:** Anpassung der Widget-Tests an die neue `AppDependencies`-Struktur.
- [ ] **TASK-14:** Integrationstests des Demo-Workflows bis zur Anzeige des Dashboards[cite: 2].

## Schritt 10: Finalization & Release

- [ ] **TASK-15:** Erstellung des Android-APK-Builds für Präsentationen beim Kunden [Demo-Modus](cite: 2).
