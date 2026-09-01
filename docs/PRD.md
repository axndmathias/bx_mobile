# Product Requirements Document (PRD) — BXMobile

**Projekt:** BXMobile
**Autor:** Alexandre Evangelista Mathias
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.1 (Aktualisiert)

---

## 1. Produktübersicht

**BXMobile** ist eine modulare, universelle SaaS-Mobile-Suite, die in Flutter/Dart unter **Clean Architecture** und **MVVM** für das Bexio ERP-Ökosystem entwickelt wird[cite: 4].

BXMobile nutzt das Konzept einer **Shell App (Container App)**[cite: 4]. Der Benutzer installiert nur eine einzige Anwendung, während die einzelnen Module basierend auf dem Abonnements- und Lizenzstatus des Kunden dynamisch freigeschaltet werden[cite: 4].

Das Ökosystem verfolgt eine strikte *Offline-First*-Strategie auf dem Mobilgerät mit asynchroner, bidirektionaler Synchronisierung über die Bexio REST API v2[cite: 4].

---

## 2. Modul-Ökosystem (BMX-Familie im Container-System)

* **BMXService:** Field Service / Serviceaufträge vor Ort, technische Berichte mit digitaler Unterschrift und Abrechnung[cite: 4].
* **BMXStock / BMXArticle:** Artikelkatalog-Verwaltung, Lagerbewegungen, Inventur und Barcode-/QR-Code-Scanning[cite: 4].
* **BMXAdresse:** Dezentrales CRM, Kontakt- und Kundenverwaltung [*Kontakte*](cite: 4).
* **BMXInvoice:** Erstellung von Offerten, Rechnungen und Schweizer QR-Rechnungen [QR-Bill](cite: 4).

---

## 3. Architekturrichtlinien & Tech Stack

* **Framework & Sprache:** Flutter / Dart[cite: 4]
* **Zielplattformen:**
  * **Hauptziel (Feldeinsatz/Lager):** Android (APK/AAB) — Fokus auf Offline-First-Stabilität und hohe Performance[cite: 4].
  * **Entwicklungs- & Backoffice-Ziele:** Windows Desktop und Web [Chrome / PWA](cite: 4).
* **Code-Architektur:** Clean Architecture + MVVM [Modular Monolith / Feature-First](cite: 4).
  * **Presentation:** `View` + `ViewModel` / `ChangeNotifier` (natives State Management via `ListenableBuilder`)
  * **Domain:** `Entities` + `UseCases` + `Repository Interfaces`[cite: 4]
  * **Data:** `DataSources` + `Repository Implementations` + `Models`[cite: 4]
* **Dependency Injection:** Manueller Bootstrap-Container via `AppDependencies` (`lib/app_dependencies.dart`) ohne globale Service-Locator-Bibliotheken.
* **Netzwerkschicht:** `BxmHttpClient` mit `Bearer Token`-Injection und `BxmOAuthClient` mit Sandbox-/Demo-Modus-Unterstützung[cite: 4].
* **Lokale Datenhaltung:** Garantierter Offline-Support ohne externe relationale Datenbank, basierend auf verschlüsselten lokalen **JSON-Dateien (AES-256)** via `path_provider` (`app_license.sec.json`)[cite: 4].

---

## 4. Zugangsmodi & Lizenzierung

1. **Demo-Modus (Demo-Benutzer - Priorität 1):**
   * Vereinfachter Zugang ohne Erfordernis eines QR-Code-Scans[cite: 4].
   * Direkte Anbindung an die **Bexio ERP Sandbox-Umgebung**[cite: 4].
   * Vollständige Freischaltung aller Module (*BMXService, BMXStock, BMXAdresse, BMXInvoice*) mit Testdaten für Kundenpräsentationen und Demonstrationen[cite: 4].
   * Generiert ein lokales Demo-Lizenz-Payload, das verschlüsselt in JSON gespeichert wird[cite: 4].
2. **Produktions-Modus / Traditionell (QR-Code - Priorität 2):**
   * Aktivierung über einmaliges Scannen des QR-Codes aus dem Lizenzdokument des Kunden (`tenant_id`, `license_key`, `server_url`, `user_name`, `modules`)[cite: 4].
   * Tägliche Authentifizierung über Benutzername und Passwort nach erfolgter Aktivierung[cite: 4].
3. **Einzelner Container (Shell App):** Ein einziges APK/AAB bedient sowohl Testbenutzer (Demo) als auch Endkunden in der Produktion[cite: 4].

---

## 5. Nicht-funktionale Anforderungen

* **NFA01 - Performance:** Cold-Start-Zeit von unter 1,5 Sekunden[cite: 4].
* **NFA02 - Speicher-Sicherheit:** Keine Speicherung von Passwörtern oder Lizenzdaten im Klartext[cite: 4]. Nutzung von `path_provider` in geschützten App-Verzeichnissen[cite: 4].
* **NFA03 - Benutzerfreundlichkeit:** Moderne Benutzeroberfläche, Unterstützung für Light/Dark-Themes und intuitive Ein-Klick-Navigation[cite: 4].
