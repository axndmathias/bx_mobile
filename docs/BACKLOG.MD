# Projekt-Backlog — Modul Benutzer & Authentifizierung

**Projekt:** BXMobile
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.0

---

## Schritt 01: Requirements & Features

- [x] **TASK-01:** Definition von PRD, MVP sowie Spezifikation des Demo-Modus (Bexio Sandbox) und des Produktions-Modus (QR-Code).

## Schritt 02: UI & Screen Planning

- [x] **TASK-02:** User Flow für den Demo-Benutzer definieren (Home -> Als Demo anmelden -> Bexio Sandbox -> Dashboard).

## Schritt 03: Architecture & Folder Structure

- [ ] **TASK-03:** Anlegen der Clean Architecture Feature-First Ordnerstruktur (`app/`, `core/`, `features/auth/`, `features/bmx_modules/`, `shared/`).

## Schritt 04: Project Setup & Git

- [ ] **TASK-04:** Konfiguration der `pubspec.yaml` mit den erforderlichen Abhängigkeiten (`encrypt`, `path_provider`, `http`/`dio`).
- [ ] **TASK-05:** Bereinigung des Repositories und Aufsetzen des Git-Branchings.

## Schritt 05: Data Models

- [ ] **TASK-06:** Implementierung von `BxmLicenseModel` und `UserModel` mit Unterstützung für das Demo-Flag (`isDemo: true`).

## Schritt 06: Services & API Integration (Bexio Demo)

- [ ] **TASK-07:** Erstellung des `SecureJsonStorageService` für die lokale AES-256-Verschlüsselung (`core/storage/`).
- [ ] **TASK-08:** Konfiguration des `BxmDemoService` für die direkte Integration mit der Bexio ERP Sandbox API (Mock/Demo Tokens).

## Schritt 07: State Management

- [ ] **TASK-09:** Erstellung des `AuthViewModel` zur Verwaltung des Demo-Login-Status und des Umgebungswechsels (`ValueNotifier`).

## Schritt 08: UI & Screen Development (Fokus Demo)

- [ ] **TASK-10:** Erstellung des Willkommens-Bildschirms mit hervorgehobener Schaltfläche "Demo-Modus starten (Bexio)".
- [ ] **TASK-11:** Erstellung des Haupt-Dashboards mit visuellem Hinweis "Demo-Modus aktiv".
- [ ] **TASK-12:** (Phase 2) Entwicklung des QR-Code-Scanners und des traditionellen Logins.

## Schritt 09: Testing & Debugging

- [ ] **TASK-13:** Unit-Tests für den `SecureJsonStorageService` und die Einbindung der Bexio-Demo-Zugangsdaten.
- [ ] **TASK-14:** Integrationstests des Demo-Workflows bis zur Anzeige des Dashboards.

## Schritt 10: Finalization & Release

- [ ] **TASK-15:** Erstellung des Android-APK-Builds für Präsentationen beim Kunden (Demo-Modus).
