# Product Requirements Document (PRD) — BXMobile

**Projekt:** BXMobile
**Autor:** Alexandre Evangelista Mathias
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.0

---

## 1. Produktübersicht

**BXMobile** ist eine modulare, universelle SaaS-Mobile-Suite, die in Flutter/Dart unter **Clean Architecture** und **MVVM** für das Bexio ERP-Ökosystem entwickelt wird.

BXMobile nutzt das Konzept einer **Shell App (Container App)**. Der Benutzer installiert nur eine einzige Anwendung, während die einzelnen Module basierend auf dem Abonnements- und Lizenzstatus des Kunden dynamisch freigeschaltet werden.

Das Ökosystem verfolgt eine strikte *Offline-First*-Strategie auf dem Mobilgerät mit asynchroner, bidirektionaler Synchronisierung über die Bexio REST API v2.

---

## 2. Modul-Ökosystem (BMX-Familie im Container-System)

* **BMXService:** Field Service / Serviceaufträge vor Ort, technische Berichte mit digitaler Unterschrift und Abrechnung.
* **BMXStock / BMXArticle:** Artikelkatalog-Verwaltung, Lagerbewegungen, Inventur und Barcode-/QR-Code-Scanning.
* **BMXAdresse:** Dezentrales CRM, Kontakt- und Kundenverwaltung (*Kontakte*).
* **BMXInvoice:** Erstellung von Offerten, Rechnungen und Schweizer QR-Rechnungen (QR-Bill).

---

## 3. Architekturrichtlinien & Tech Stack

* **Framework & Sprache:** Flutter / Dart
* **Zielplattformen:**
  * **Hauptziel (Feldeinsatz/Lager):** Android (APK/AAB) — Fokus auf Offline-First-Stabilität und hohe Performance.
  * **Entwicklungs- & Backoffice-Ziele:** Windows Desktop und Web (Chrome / PWA).
* **Code-Architektur:** Clean Architecture + MVVM (Modular Monolith / Feature-First).
  * **Presentation:** `View` + `ViewModel` (`ValueNotifier` / `ChangeNotifier`)
  * **Domain:** `Entities` + `UseCases` + `Repository Interfaces`
  * **Data:** `DataSources` + `Repository Implementations` + `Models`
* **Netzwerkschicht:** `BxmHttpClient` mit `Bearer Token`-Injection und `BxmOAuthClient` mit Sandbox-/Demo-Modus-Unterstützung.
* **Lokale Datenhaltung:** Garantierter Offline-Support ohne externe relationale Datenbank, basierend auf verschlüsselten lokalen **JSON-Dateien (AES-256)** via `path_provider` (`app_license.sec.json`).

---

## 4. Zugangsmodi & Lizenzierung

1. **Demo-Modus (Demo-Benutzer - Priorität 1):**
   * Vereinfachter Zugang ohne Erfordernis eines QR-Code-Scans.
   * Direkte Anbindung an die **Bexio ERP Sandbox-Umgebung**.
   * Vollständige Freischaltung aller Module (*BMXService, BMXStock, BMXAdresse, BMXInvoice*) mit Testdaten für Kundenpräsentationen und Demonstrationen.
   * Generiert ein lokales Demo-Lizenz-Payload, das verschlüsselt in JSON gespeichert wird.
2. **Produktions-Modus / Traditionell (QR-Code - Priorität 2):**
   * Aktivierung über einmaliges Scannen des QR-Codes aus dem Lizenzdokument des Kunden (`tenant_id`, `license_key`, `server_url`, `user_name`, `modules`).
   * Tägliche Authentifizierung über Benutzername und Passwort nach erfolgter Aktivierung.
3. **Einzelner Container (Shell App):** Ein einziges APK/AAB bedient sowohl Testbenutzer (Demo) als auch Endkunden in der Produktion.

---

## 5. Nicht-funktionale Anforderungen

* **NFA01 - Performance:** Cold-Start-Zeit von unter 1,5 Sekunden.
* **NFA02 - Speicher-Sicherheit:** Keine Speicherung von Passwörtern oder Lizenzdaten im Klartext. Nutzung von `path_provider` in geschützten App-Verzeichnissen.
* **NFA03 - Benutzerfreundlichkeit:** Moderne Benutzeroberfläche, Unterstützung für Light/Dark-Themes und intuitive Ein-Klick-Navigation.
