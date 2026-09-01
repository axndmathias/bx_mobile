# MVP-Spezifikation (Minimum Viable Product) — BXMobile

**Projekt:** BXMobile
**Aktualisierungsdatum:** August 2026
**Version:** 0.1.1 (Aktualisiert)

---

## 1. Ziele des MVP

Validierung des vollständigen Zyklus des **Demo-Modus (Bexio Sandbox)** ohne QR-Code, gefolgt von der Integration des traditionellen QR-Code-Workflows, der lokalen Persistenz in verschlüsseltem JSON ohne Datenbank, der Benutzerauthentifizierung via `ChangeNotifier` / `AppDependencies` und der dynamischen Menüdarstellung aller Systemmodule [*BMXAdresse, BMXStock/BMXArticle, BMXService, BMXInvoice*](cite: 3).

## 2. Umfang des MVP (In Scope)

1. **Phase 1: Workflow des Demo-Benutzers (Aktualisiert & Implementiert)**
   - Option "Als Demo-Benutzer anmelden / Demo Modus" auf dem Startbildschirm[cite: 3].
   - Laden von Anmeldeinformationen und Tokens aus der Bexio ERP Sandbox API[cite: 3].
   - Generierung und Speicherung der Datei `app_license.sec.json` im Demo-Format via `SecureJsonStorageService`[cite: 3].
   - Direkter Zugriff auf das Dashboard mit allen freigeschalteten Modulen im Testmodus[cite: 3].
2. **Phase 2: Traditioneller Workflow (QR-Code & Login)**
   - QR-Code-Scanner (`mobile_scanner`)[cite: 3].
   - Auslesen des Produktions-Payloads, Speicherung des verschlüsselten JSONs und täglicher Login-Bildschirm mit Benutzername und Passwort[cite: 3].
3. **App-Core & Dashboard:**
   - Grundlegende Clean Architecture + MVVM Infrastruktur mit manuellem DI-Container (`AppDependencies`) und `ChangeNotifier`[cite: 3].
   - `LicenseService` für die zentrale Verwaltung des Lizenzstatus [Demo vs. Produktion](cite: 3).
   - Dashboard (Home) mit dynamischer Menüführung[cite: 3].

## 3. Ausserhalb des MVP-Umfangs (Zukünftige Phasen)

- Komplexe bidirektionale Synchronisierung mit ERP-Systemen [Bexio/Proffix](cite: 3).
- Drucken von Dokumenten über Bluetooth/Wi-Fi[cite: 3].
- Erfassung von Barcodes/QR-Codes innerhalb des BMXStock-Moduls[cite: 3].
